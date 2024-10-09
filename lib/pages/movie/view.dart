import 'package:ddys/common/model/entity.dart';
import 'package:ddys/pages/video/index.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:getx_scaffold/getx_scaffold.dart';

import 'index.dart';

class MoviePage extends GetView<MovieController> {
  const MoviePage({super.key});

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
            return _buildArticle(article);
          },
          itemCount: controller.articleList.length,
        );
      },
    );
  }

  Card _buildArticle(Article article) {
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
        ).onTap(() {
          Get.to(() => VideoPage(), arguments: {'url': article.url});
        }));
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: GetBuilder<MovieController>(
        init: MovieController(),
        id: 'movie',
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
                title: <Widget>[
                  ButtonX.text(
                    '全部',
                    textWeight: controller.currentIndex == 0
                        ? FontWeight.bold
                        : FontWeight.normal,
                    foregroundColor: controller.currentIndex == 0
                        ? Colors.black
                        : ThemeColor.primary,
                    onPressed: () {
                      controller.setCurrentIndex(0);
                    },
                  ),
                  ButtonX.text('欧美',
                      textWeight: controller.currentIndex == 1
                          ? FontWeight.bold
                          : FontWeight.normal,
                      foregroundColor: controller.currentIndex == 1
                          ? Colors.black
                          : ThemeColor.primary, onPressed: () {
                    controller.setCurrentIndex(1);
                  }),
                  ButtonX.text('日韩',
                      textWeight: controller.currentIndex == 2
                          ? FontWeight.bold
                          : FontWeight.normal,
                      foregroundColor: controller.currentIndex == 2
                          ? Colors.black
                          : ThemeColor.primary, onPressed: () {
                    controller.setCurrentIndex(2);
                  }),
                  ButtonX.text('华语',
                      textWeight: controller.currentIndex == 3
                          ? FontWeight.bold
                          : FontWeight.normal,
                      foregroundColor: controller.currentIndex == 3
                          ? Colors.black
                          : ThemeColor.primary, onPressed: () {
                    controller.setCurrentIndex(3);
                  })
                ].toListView(scrollDirection: Axis.horizontal).height(40.dm),
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
      ),
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
