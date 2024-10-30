import 'package:ddys/common/model/entity.dart';
import 'package:ddys/utils/parse.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:getx_scaffold/getx_scaffold.dart';
import 'package:html/parser.dart';

class SearchPageController extends GetxController with BaseControllerMixin {
  var searchController = TextEditingController();
  var smartController = EasyRefreshController();

  var page = 1;

  List<Article> articleList = [];

  @override
  String get builderId => 'search';
  String keyword = '';
  SearchPageController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> onRefresh() async {
    page = 1;
    articleList.clear();
    updateUi();
    await getSearchData();
  }

  Future<void> onLoading() async {
    page++;
    await getSearchData();
  }

  void search() {
    keyword = searchController.text;
    if (keyword.isNotEmptyOrNull) {
      page = 1;
      articleList.clear();
      updateUi();
      getSearchData();
    }
  }

  Future<void> getSearchData() async {
    if (keyword.isEmptyOrNull) {
      return;
    }
    showLoading();
    var response = await HttpService.to.get(
        page == 1 ? 'https://ddys.pro/' : 'https://ddys.pro/page/$page/',
        params: {'s': keyword, 'post_type': 'post'});
    if (response != null) {
      var articleElementList = parse(response.data).querySelectorAll('article');
      var articles = parseSearchArticleList(articleElementList);
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
}
