import 'package:ddys/common/model/entity.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:getx_scaffold/getx_scaffold.dart';

import '../video/view.dart';
import 'index.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  // 主视图
  Widget _buildView() {
    return EasyRefresh.builder(
      controller: controller.smartController,
      onRefresh: () async {
        controller.onRefresh();
      },
      onLoad: () async {
        controller.onLoading();
      },
      childBuilder: (context, physics) {
        return ListView.builder(
          physics: physics,
          itemBuilder: (context, index) {
            var article = controller.articleList[index];
            return ListTileX(
              title: article.name,
              subTitle: _getSubText(article),
              trailing: Row(
                children: _buildCates(article.categories),
              ),
              onTap: () {
                Get.to(() => const VideoPage(),
                    arguments: {'url': article.url});
              },
            );
          },
          itemCount: controller.articleList.length,
        );
      },
    );
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

  List<Widget> _buildCates(List<Category> categories) {
    List<Widget> cates = [];
    for (var cate in categories) {
      cates.add(TextTag(cate.name));
    }
    return cates.sublist(0, 1);
  }

  String _getSubText(Article article) {
    var latest = article.latest;
    var remark = article.remark;
    if (latest.isNotEmptyOrNull && remark.isNotEmptyOrNull) {
      return '$latest  $remark';
    } else if (latest.isNotEmptyOrNull) {
      return latest;
    } else if (remark.isNotEmptyOrNull) {
      return remark!;
    } else {
      return '';
    }
  }
}
