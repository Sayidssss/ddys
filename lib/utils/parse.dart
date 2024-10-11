import 'package:ddys/common/model/entity.dart';
import 'package:ddys/pages/video/view.dart';
import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:html/dom.dart' as dom;

List<Article> parseArticleList(List<dom.Element> list) {
  return list.map((a) {
    var url = a.attributes['data-href']!;
    var container = a.querySelector('div.post-box-image');
    String bg = container!.attributes['style']!;
    var pic = "";
    if (bg != 'background-image: url();') {
      pic = bg.substring(bg.indexOf("https://"), bg.indexOf(")"));
    }
    var name = a.querySelector('div.post-box-text > h2')!.text;
    var remark = a.querySelector('div.post-box-text > p')?.text;
    var categories = a.querySelectorAll('.post-box-meta > a');
    List<Category> categoryList = [];
    for (var cate in categories) {
      var cName = cate.text;
      var cUrl = cate.attributes['href']!;
      var category = Category(name: cName, url: cUrl);
      categoryList.add(category);
    }
    Article article = Article(name, url, pic, remark, categoryList);
    return article;
  }).toList();
}

Card buildArticle(Article article) {
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
            headers: {'Referer': 'https://ddys.pro/'},
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

List<Widget> _getCates(List<Category> categories) {
  List<Widget> list = [];
  for (var cate in categories) {
    list.add(TextX(cate.name, size: 6.sp).marginOnly(right: 5.dm));
  }
  return list;
}

// Video parseVideoInfo() {}
