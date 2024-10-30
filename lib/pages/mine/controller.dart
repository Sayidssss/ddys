import 'package:getx_scaffold/getx_scaffold.dart';

class MineController extends GetxController with BaseControllerMixin {
  var isAutoNext = getBoolAsync('is_auto_next');
  var isAutoSub = getBoolAsync('is_auto_sub');
  var isAutoFav = getBoolAsync('is_auto_fav');

  var domainList = ['https://ddys.pro/', 'https://ddys.mov/'];

  @override
  String get builderId => 'mine';

  MineController();

  @override
  void onInit() {
    super.onInit();
  }

  void setAutoNext(bool b) {
    isAutoNext = b;
    setValue('is_auto_next', isAutoNext);
    updateUi();
  }

  void setAutoSub(bool b) {
    isAutoSub = b;
    setValue('is_auto_sub', isAutoSub);
    updateUi();
  }

  void setAutoFav(bool b) {
    isAutoFav = b;
    setValue('is_auto_fav', isAutoFav);
    updateUi();
  }
}
