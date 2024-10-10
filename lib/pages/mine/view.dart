import 'package:ddys/utils/parse.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:getx_scaffold/getx_scaffold.dart';

import 'index.dart';

class MinePage extends GetView<MineController> {
  const MinePage({super.key});

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
      childBuilder: (context, physic) {
        return GridView.builder(
          physics: physic,
          padding: EdgeInsets.all(10.dm),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.dm,
            mainAxisSpacing: 10.dm,
            childAspectRatio: 1.0 / 1.8,
          ),
          itemBuilder: (context, index) {
            var article = controller.articleList[index];
            return buildArticle(article);
          },
          itemCount: controller.articleList.length,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MineController>(
      init: MineController(),
      id: 'mine',
      builder: (_) {
        return KeepAliveWrapper(
          child: Scaffold(
            extendBody: false,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                title: buildCates(controller.cateNames)
                    .toListView(scrollDirection: Axis.horizontal)
                    .height(40.dm),
                elevation: 1),
            body: SafeArea(
              child: _buildView(),
            ),
          ),
        );
      },
    );
  }

  List<Widget> buildCates(names) {
    List<Widget> list = [];
    for (int i = 0; i < names.length; i++) {
      list.add(ButtonX.text(names[i],
          textWeight: controller.currentIndex == i
              ? FontWeight.bold
              : FontWeight.normal,
          foregroundColor: controller.currentIndex == i
              ? Colors.black
              : ThemeColor.primary, onPressed: () {
        controller.setCurrentIndex(i);
      }));
    }
    return list;
  }
}
