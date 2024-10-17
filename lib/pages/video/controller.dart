import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:ddys/common/model/entity.dart';
import 'package:ddys/common/model/video.dart';
import 'package:encrypt/encrypt.dart' as Enc;
import 'package:flick_video_player/flick_video_player.dart';
import 'package:getx_scaffold/getx_scaffold.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController with BaseControllerMixin {
  @override
  String get builderId => 'video';

  VideoController();

  String url = '';
  Video? video;
  FlickManager? flickManager;

  static String _currentUrl = "";

  int trackIndex = 0;
  @override
  void onInit() {
    super.onInit();
    url = (Get.arguments as Map<String, String>)['url']!;
    flickManager = FlickManager(
        videoPlayerController:
            VideoPlayerController.networkUrl(Uri.parse(_currentUrl)));
    getVideoInfo();
  }

  @override
  void onClose() {
    flickManager?.dispose();
    super.onClose();
  }

  Future getVideoInfo() async {
    showLoading();
    var response = await HttpService.to.get(url);
    if (response != null) {
      var doc = parse(response.data);
      video = _parseVideoInfo(doc);
      _currentUrl = 'https://v.ddys.pro${video!.videoMeta!.tracks[0].src0}';
      flickManager?.handleChangeVideo(
        VideoPlayerController.networkUrl(Uri.parse(_currentUrl),
            closedCaptionFile: getSubs(video!.videoMeta!.tracks[0].subsrc),
            httpHeaders: {'Referer': 'https://ddys.pro/'}),
      );
      updateUi();
    }
    dismissLoading();
  }

  Video _parseVideoInfo(Document doc) {
    var title = doc.querySelector('div.post-content > h1')?.text;
    var publishDate = doc
        .querySelector(
            'div.post-content > div.metadata > ul > li.meta_date > time.entry-date.published')
        ?.text;
    var updatedDate = doc
        .querySelector(
            'div.post-content > div.metadata > ul > li.meta_date > time.updated')
        ?.text;
    var categories = doc.querySelectorAll(
        'div.post-content > div.metadata > ul > li.meta_categories > span > a');
    List<Category> categoryList = [];
    for (var cate in categories) {
      var cName = cate.text;
      var cUrl = cate.attributes['href']!;
      var category = Category(name: cName, url: cUrl);
      categoryList.add(category);
    }

    var tags = doc.querySelectorAll(
        'div.post-content > div.metadata > ul > li.meta_tags > span > a');
    List<Tag> tagList = [];
    for (var tag in tags) {
      var cName = tag.text;
      var cUrl = tag.attributes['href']!;
      var t = Tag(name: cName, url: cUrl);
      tagList.add(t);
    }
    VideoMeta? videoMeta;
    var json = doc
        .querySelector(
            'div.post-content > div.entry > div.wp-playlist.wp-video-playlist.wp-playlist-light.wpse-playlist > script')
        ?.text;
    if (json != null) {
      videoMeta = VideoMeta.fromJson(jsonDecode(json));
    }

    var post = doc
        .querySelector(
            'div.post-content > div.entry > div.doulist-item > div > div > div.post > img')
        ?.attributes['src'];

    var _title = doc
        .querySelector(
            'div.post-content > div.entry > div.doulist-item > div > div > div.title')
        ?.text;

    var rating = doc
        .querySelector(
            'div.post-content > div.entry > div.doulist-item > div > div > div.rating > span.rating_nums')
        ?.text
        .trim();

    var abstractAll = doc
        .querySelector(
            'div.post-content > div.entry > div.doulist-item > div > div > div.abstract')
        ?.innerHtml;
    VideoIntro? videoIntro;
    if (abstractAll != null) {
      List<String> abList = abstractAll.split('<p></p>');
      var intro = abList[1];
      var abs = abList[0].replaceAll('<br>', '\n');
      videoIntro = VideoIntro(post, _title, rating, abs, intro);
    }
    List<Season>? seasonList = [];
    var seasonAll = doc.querySelectorAll(
        '#post-2530 > div.post-content > div.entry > div.page-links >.post-page-numbers');
    for (var child in seasonAll) {
      seasonList.add(Season(
          name: child.text,
          url: child.localName == 'span' ? url : child.attributes['href']!,
          isCurrent: child.localName == 'span'));
    }

    return Video(title, publishDate, updatedDate, categoryList, tagList,
        videoMeta, videoIntro, seasonList);
  }

  void setCurrentTrack(Track? track) {
    if (track == null) {
      return;
    }
    _currentUrl = 'https://v.ddys.pro${track.src0}';
    flickManager?.handleChangeVideo(
      VideoPlayerController.networkUrl(Uri.parse(_currentUrl),
          closedCaptionFile: getSubs(track.subsrc),
          httpHeaders: {'Referer': 'https://ddys.pro/'}),
    );
    updateUi();
  }

  void setTrack(int index) {
    trackIndex = index;
    setCurrentTrack(video?.videoMeta?.tracks[index]);
  }

  Future<ClosedCaptionFile> getSubs(String subsrc) async {
    var path = (await getTemporaryDirectory()).path;
    var array = subsrc.split('/');
    var filename = array[array.length - 1];
    var name = filename.split('.')[0];
    var response = await HttpService.to.dio.download(
        'https://ddys.pro/subddr${subsrc}', '${path}${filename}',
        options: Options(headers: {'Referer': 'https://ddys.pro/'}));
    if (response != null) {
      File file = File.fromUri(Uri.file('${path}${filename}'));
      var fileBytes = file.readAsBytesSync();
      var wordArray = fileBytes.sublist(16);
      var hexString = fileBytes
          .sublist(0, 16)
          .map(
            (x) {
              var y = x.toRadixString(16);
              var str = '00$y';
              return str.substring(str.length - 2);
            },
          )
          .toList()
          .join();
      final iv = Enc.IV.fromBase16(hexString);
      final encrypter = Enc.Encrypter(
          Enc.AES(Enc.Key.fromBase16(hexString), mode: Enc.AESMode.cbc));
      var list = encrypter.decryptBytes(
        Enc.Encrypted(wordArray),
        iv: iv,
      );
      var archive = GZipDecoder().decodeBytes(list);
      var txt = utf8.decode(archive);
      ClosedCaptionFile vtt = WebVTTCaptionFile(txt);
      log(txt);
      return vtt;
    } else {
      ClosedCaptionFile vtt = WebVTTCaptionFile('');
      return vtt;
    }
  }
}
