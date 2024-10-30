import 'package:ddys/pages/search/index.dart';
import 'package:ddys/utils/parse.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:getx_scaffold/getx_scaffold.dart';

import '../history/index.dart';
import 'index.dart';

class IndexPage extends GetView<IndexController> {
  const IndexPage({super.key});

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
    return KeepAliveWrapper(
      child: GetBuilder<IndexController>(
        init: IndexController(),
        id: 'index',
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
                leading: IconX.icon(
                  Icons.watch_later_outlined,
                  width: 50.dm,
                  height: 50.dm,
                  color: ThemeColor.primary,
                ).paddingSymmetric(horizontal: 10.dm, vertical: 5.dm).inkWell(
                    onTap: () {
                      Get.to(() => const HistoryPage(),
                          transition: Transition.fadeIn);
                    },
                    borderRadius: 5.dm),
                title: const Text('首页'),
                actions: [
                  IconX.icon(
                    AntdIcon.search,
                    width: 50.dm,
                    height: 50.dm,
                    color: ThemeColor.primary,
                  ).paddingSymmetric(horizontal: 10.dm, vertical: 5.dm).inkWell(
                      onTap: () {
                        Get.to(() => const SearchPage(),
                            transition: Transition.fadeIn);
                      },
                      borderRadius: 5.dm)
                ],
                elevation: 1),
            body: SafeArea(
              child: _buildView(),
            ),
          );
        },
      ),
    );
  }
}
