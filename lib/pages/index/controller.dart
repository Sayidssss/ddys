import 'package:ddys/common/model/entity.dart';
import 'package:ddys/utils/parse.dart';
import 'package:getx_scaffold/getx_scaffold.dart';
import 'package:html/parser.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class IndexController extends GetxController with BaseControllerMixin {
  @override
  String get builderId => 'index';

  IndexController();
  List<Article> articleList = [];
  var page = 1;

  var smartController = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> getIndexData() async {
    var response = await HttpService.to.get('https://ddys.pro/page/$page/');
    if (response != null) {
      var articleElementList = parse(response.data).querySelectorAll('article');
      var articles = parseArticleList(articleElementList);
      if (page == 1) {
        articleList.clear();
        articleList.addAll(articles);
        smartController.refreshCompleted();
      } else {
        articleList.addAll(articles);
        if (articles.isEmpty) {
          smartController.loadNoData();
        } else {
          smartController.loadComplete();
        }
      }
      updateUi();
    }
  }

  onRefresh() async {
    page = 1;
    getIndexData();
  }

  onLoading() async {
    page++;
    getIndexData();
  }
}
