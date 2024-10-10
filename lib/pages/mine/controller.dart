import 'package:ddys/common/model/entity.dart';
import 'package:ddys/utils/parse.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:getx_scaffold/getx_scaffold.dart';
import 'package:html/parser.dart';

class MineController extends GetxController with BaseControllerMixin {
  @override
  String get builderId => 'mine';
  List<String> urls = [
    'https://ddys.pro/tag/action/',
    'https://ddys.pro/tag/comedy/',
    'https://ddys.pro/tag/romance/',
    'https://ddys.pro/tag/sci-fi/',
    'https://ddys.pro/tag/crime/',
    'https://ddys.pro/tag/mystery/',
    'https://ddys.pro/tag/horror/'
  ];
  List<String> cateNames = ['动作', '喜剧', '爱情', '科幻', '犯罪', '悬疑', '恐怖'];
  List<Article> articleList = [];
  var page = 1;
  var currentIndex = 0;
  var smartController = EasyRefreshController();
  MineController();

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
