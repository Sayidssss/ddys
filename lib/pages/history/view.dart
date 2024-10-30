import 'package:ddys/common/model/entity.dart';
import 'package:ddys/pages/video/view.dart';
import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:getx_scaffold/getx_scaffold.dart';

import 'index.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

// 主视图
  Widget _buildView() {
    return GridView.builder(
      padding: EdgeInsets.all(10.dm),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.dm,
        mainAxisSpacing: 10.dm,
        childAspectRatio: 1.0 / 1.8,
      ),
      itemBuilder: (context, index) {
        var article = controller.list[index];
        return buildArticle(article);
      },
      itemCount: controller.list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
      init: HistoryController(),
      id: 'history',
      builder: (_) {
        return Scaffold(
          extendBody: false,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: const Text('观看历史'), elevation: 1),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }

  Card buildArticle(History article) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.dm))),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ExtendedImage.network(
                  article.img,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  headers: {'Referer': 'https://ddys.pro/'},
                ),
              ],
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
                    size: 12.sp,
                    maxLines: 1,
                  ),
                  if (article.season != -1)
                    TextX.bodySmall(
                        '看到 第${article.season}季 第${article.eps + 1}集')
                  else
                    TextX.bodySmall('已看到 第${article.eps + 1}集'),
                ],
              ),
            )
          ],
        ).onTap(() {
          Get.to(() => VideoPage(),
              arguments: {'url': article.url, 'trackIndex': '${article.eps}'});
        }));
  }
}
