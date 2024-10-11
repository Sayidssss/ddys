import 'package:getx_scaffold/getx_scaffold.dart';

class SearchPageController extends GetxController with BaseControllerMixin {
  var searchController = TextEditingController();

  @override
  String get builderId => 'search';

  SearchPageController();

  @override
  void onInit() {
    super.onInit();
  }

  void search() {}
}
