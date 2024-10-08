import 'dart:convert';

import 'package:ddys/common/model/entity.dart';
import 'package:ddys/common/model/video.dart';
import 'package:getx_scaffold/getx_scaffold.dart';
import 'package:html/parser.dart';

class VideoController extends GetxController with BaseControllerMixin {
  @override
  String get builderId => 'video';

  VideoController();
  String url = '';

  String? title;
  @override
  void onInit() {
    super.onInit();
    url = (Get.arguments as Map<String, String>)['url']!;
    getVideoInfo();
  }

  Future getVideoInfo() async {
    var response = await HttpService.to.get(url);
    if (response != null) {
      var doc = parse(response.data);
      title = doc.querySelector('div.post-content > h1')?.text;
      var publishDate = doc
          .querySelector(
              'div.post-content > div.metadata > ul > li.meta_date > time.entry-date.published')
          ?.text;
      var updatedDate = doc
          .querySelector(
              'div.post-content > div.metadata > ul > li.meta_date > time.updated')
          ?.text;
      var categories = doc.querySelectorAll(
          'div.post-content > div.metadata > ul > li.meta_categories > span > a');
      List<Category> categoryList = [];
      for (var cate in categories) {
        var cName = cate.text;
        var cUrl = cate.attributes['href']!;
        var category = Category(name: cName, url: cUrl);
        categoryList.add(category);
      }

      var tags = doc.querySelectorAll(
          'div.post-content > div.metadata > ul > li.meta_tags > span > a');
      List<Tag> tagList = [];
      for (var tag in tags) {
        var cName = tag.text;
        var cUrl = tag.attributes['href']!;
        var t = Tag(name: cName, url: cUrl);
        tagList.add(t);
      }

      var json = doc
          .querySelector(
              'div.post-content > div.entry > div.wp-playlist.wp-video-playlist.wp-playlist-light.wpse-playlist > script')
          ?.text;
      if (json != null) {
        VideoMeta video = VideoMeta.fromJson(jsonDecode(json));
      }

      var post = doc
          .querySelector(
              'div.post-content > div.entry > div.doulist-item > div > div > div.post > img')
          ?.attributes['src'];

      var _title = doc
          .querySelector(
              'div.post-content > div.entry > div.doulist-item > div > div > div.title')
          ?.text;

      var rating = doc
          .querySelector(
              'div.post-content > div.entry > div.doulist-item > div > div > div.rating > span.rating_nums')
          ?.text
          .trim();

      var abstract_all = doc
          .querySelector(
              'div.post-content > div.entry > div.doulist-item > div > div > div.abstract')
          ?.innerHtml;
      if (abstract_all != null) {
        List<String> ab_list = abstract_all.split('<p></p>');
        var intro = ab_list[1];
        var abs = ab_list[0]!.replaceAll('<br>', '\n');
        VideoIntro videoIntro = VideoIntro(post, title, rating, abs, intro);
      }
    }
  }
}
