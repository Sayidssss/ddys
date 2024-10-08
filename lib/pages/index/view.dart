import 'package:ddys/common/model/entity.dart';
import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:getx_scaffold/getx_scaffold.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'index.dart';

class IndexPage extends GetView<IndexController> {
  const IndexPage({super.key});

  // 主视图
  Widget _buildView() {
    return SmartRefresher(
      controller: controller.smartController,
      // onRefresh: controller.onRefresh(),
      // onLoading: controller.onLoading(),
      child: GridView.builder(
        padding: EdgeInsets.all(10.dm),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.dm,
          mainAxisSpacing: 10.dm,
          childAspectRatio: 1.0 / 1.8,
        ),
        itemBuilder: (context, index) {
          var article = controller.articleList[index];
          return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.dm))),
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExtendedImage.network(
                    article.pic,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ).aspectRatio(aspectRatio: 1.0 / 1.414),
                  Container(
                    padding: EdgeInsets.all(5.dm),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextX(
                          article.name,
                          size: 10.sp,
                          maxLines: 1,
                        ),
                        Row(
                          children: _getCates(article.categories),
                        ),
                        if (article.remark != null)
                          TextX(
                            article.remark!,
                            size: 6.sp,
                          ),
                      ],
                    ),
                  )
                ],
              ));
        },
        itemCount: controller.articleList.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexController>(
      init: IndexController(),
      id: 'index',
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
              title: const Text('首页'),
              actions: [
                IconX.icon(
                  AntdIcon.search,
                  width: 50.dm,
                  height: 50.dm,
                )
                    .paddingSymmetric(horizontal: 10.dm, vertical: 5.dm)
                    .inkWell(onTap: () {}, borderRadius: 5.dm)
              ],
              elevation: 1),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }

  List<Widget> _getCates(List<Category> categories) {
    List<Widget> list = [];
    for (var cate in categories) {
      list.add(TextX(cate.name, size: 6.sp).marginOnly(right: 5.dm));
    }
    return list;
  }
}
