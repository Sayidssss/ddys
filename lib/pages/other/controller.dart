import 'package:ddys/common/model/entity.dart';
import 'package:ddys/utils/parse.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:getx_scaffold/getx_scaffold.dart';
import 'package:html/parser.dart';

class OtherController extends GetxController with BaseControllerMixin {
  @override
  String get builderId => 'other';
  List<String> urls = [
    'https://ddys.pro/category/anime/',
    'https://ddys.pro/category/documentary/',
    'https://ddys.pro/category/variety/',
    'https://ddys.pro/category/concert/'
  ];
  List<String> cateNames = ['动漫', '纪录片', '综艺', '演唱会'];
  List<Article> articleList = [];
  var page = 1;
  var currentIndex = 0;
  var smartController = EasyRefreshController();
  OtherController();
  @override
  void onInit() {
    super.onInit();
    getIndexData();
  }

  Future<void> getIndexData() async {
    if (page == 1) {
      showLoading();
    }
    var response = await HttpService.to.get('${urls[currentIndex]}page/$page/');
    if (response != null) {
      var articleElementList = parse(response.data).querySelectorAll('article');
      var articles = parseArticleList(articleElementList);
      if (page == 1) {
        articleList.clear();
        articleList.addAll(articles);
      } else {
        articleList.addAll(articles);
      }
      dismissLoading();
      updateUi();
    }
  }

  Future<void> onRefresh() async {
    page = 1;
    await getIndexData();
  }

  Future<void> onLoading() async {
    page++;
    await getIndexData();
  }

  void setCurrentIndex(int i) {
    if (currentIndex != i) {
      currentIndex = i;
      articleList.clear();
      updateUi();
      getIndexData();
    }
  }
}
