import 'package:ddys/common/model/entity.dart';
import 'package:ddys/utils/parse.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:getx_scaffold/getx_scaffold.dart';
import 'package:html/parser.dart';

class IndexController extends GetxController with BaseControllerMixin {
  @override
  String get builderId => 'index';

  IndexController();
  List<Article> articleList = [];
  var page = 1;

  var smartController = EasyRefreshController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getIndexData() async {
    var response = await HttpService.to.get('https://ddys.pro/page/$page/');
    if (response != null) {
      var articleElementList = parse(response.data).querySelectorAll('article');
      var articles = parseArticleList(articleElementList);
      if (page == 1) {
        articleList.clear();
        articleList.addAll(articles);
      } else {
        articleList.addAll(articles);
      }
      updateUi();
    }
  }

  Future<void> onRefresh() async {
    page = 1;
    await getIndexData();
  }

  Future<void>  onLoading() async {
    page++;
    await  getIndexData();
  }
}
