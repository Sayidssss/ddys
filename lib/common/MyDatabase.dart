import 'dart:io';

import 'package:ddys/common/model/entity.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._(); //单例模式

  static final DatabaseHelper db = DatabaseHelper._();
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDb();
    return _database;
  }

  //init database and open it
  Future<Database> initDb() async {
    Logger.d("initDb");
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'ddys.db');
    Logger.d("initDb $path");

    Database db = await openDatabase(path, version: 1, onOpen: (db) async {
      // 等待表创建完成
      await db.execute(
          'CREATE TABLE IF NOT EXISTS watch_history (video_key TEXT PRIMARY KEY, name TEXT, url TEXT, season INTEGER, eps INTEGER, img TEXT,time TIMESTAMP DEFAULT CURRENT_TIMESTAMP)');
      await db.execute(
          'CREATE TRIGGER IF NOT EXISTS [UpdateLastTime] AFTER UPDATE ON watch_history FOR EACH ROW BEGIN UPDATE watch_history SET time = CURRENT_TIMESTAMP WHERE video_key = old.video_key; END;');
    });
    return db;
  }

  //insert database
  Future<int?> insert(History history) async {
    Logger.d('insert data Saving History...');
    final db = await database; // 确保database在上下文中定义

    try {
      var result = await db?.rawInsert(
          'INSERT OR REPLACE INTO watch_history (video_key,name,url,season, eps,img) VALUES (?,?,?,?,?,?)',
          [
            history.videoKey,
            history.name,
            history.url,
            history.season,
            history.eps,
            history.img
          ]);
      Logger.d(
          'insert data id watch_history saved! ${history.videoKey}, ${history.name}, ${history.url}, ${history.season},${history.eps}, ${history.img}');
      return result;
    } on DatabaseException catch (e) {
      e.printError();
      return -1;
    }
  }

  //query database
  Future<List<History>> getAll() async {
    Logger.d('getAll database...');
    var db = await database;
    var query = await db?.query('watch_history', orderBy: 'time DESC');

    List<History> histories =
        query!.isNotEmpty ? query.map((t) => History.fromMap(t)).toList() : [];
    Logger.d('getAll in database: ${histories.length} ');
    return histories;
  }

  //delete sql by id
  Future<void> delete(String key) async {
    var db = await database;
    await db?.rawDelete('DELETE FROM watch_history WHERE video_key = ?', [key]);
  }

  Future<void> deleteAll() async {
    var db = await database;
    await db?.rawDelete('DELETE FROM watch_history WHERE 1 = 1');
  }

  //update database by id
  Future<void> updateDatabase(History history) async {
    final db = await database;
    await db?.update(
      'watch_history',
      history.toMap(),
      where: "video_key = ?",
      whereArgs: [history.videoKey],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
