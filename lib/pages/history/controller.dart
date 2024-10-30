import 'package:ddys/common/MyDatabase.dart';
import 'package:ddys/common/model/entity.dart';
import 'package:getx_scaffold/getx_scaffold.dart';

class HistoryController extends GetxController with BaseControllerMixin {
  @override
  String get builderId => 'history';

  HistoryController();

  List<History> list = [];

  @override
  void onInit() {
    super.onInit();
    getHistoryList();
  }

  void getHistoryList() async {
    list = await DatabaseHelper.db.getAll();
    updateUi();
  }
}
