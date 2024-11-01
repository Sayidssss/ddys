import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:getx_scaffold/getx_scaffold.dart';

class HomeController extends GetxController with BaseControllerMixin {
  @override
  String get builderId => 'home';

  HomeController();

  int pageIndex = 0;

  var pageController = PageController();
  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();
  }

  void setIndex(index) {
    pageIndex = index;
    pageController.animateToPage(pageIndex,
        duration: Duration(microseconds: 1000), curve: Curves.easeIn);
    updateUi();
  }
}
