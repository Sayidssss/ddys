import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:getx_scaffold/getx_scaffold.dart';

import 'index.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  // 主视图
  Widget _buildView() {
    return <Widget>[]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
        .padding(all: 10.w, bottom: 50.w)
        .scrollable(primary: true)
        .scrollbar()
        .width(1.sw);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPageController>(
      init: SearchPageController(),
      id: 'search',
      builder: (_) {
        return Scaffold(
          extendBody: false,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: false,
            title: TextField(
              canRequestFocus: true,
              controller: controller.searchController,
              decoration: InputDecoration(
                  label: TextX.bodyMedium('关键词'), hintText: '输入豆瓣编号也可搜索'),
            ),
            elevation: 1,
            actions: [
              Center(
                  child: ButtonX.primary(
                "搜索",
                onPressed: () {
                  controller.search();
                },
              )).marginOnly(right: 10.dm)
            ],
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
