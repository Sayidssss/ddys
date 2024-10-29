import 'package:getx_scaffold/getx_scaffold.dart';

class MineController extends GetxController with BaseControllerMixin {
  var isAutoNext = false;
  var isAutoSub = false;
  var isAutoFav = false;

  @override
  String get builderId => 'mine';

  MineController();

  @override
  void onInit() {
    super.onInit();
  }
}
