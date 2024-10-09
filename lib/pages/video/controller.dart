import 'dart:convert';

import 'package:ddys/common/model/entity.dart';
import 'package:ddys/common/model/video.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:getx_scaffold/getx_scaffold.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController with BaseControllerMixin {
  @override
  String get builderId => 'video';

  VideoController();

  String url = '';
  Video? video;
  FlickManager? flickManager ;

  static String _currentUrl = "";
  @override
  void onInit() {
    super.onInit();
    url = (Get.arguments as Map<String, String>)['url']!;
    flickManager = FlickManager(
        videoPlayerController:
        VideoPlayerController.networkUrl(Uri.parse(_currentUrl)));
    getVideoInfo();
  }

  @override
  void onClose() {
    flickManager?.dispose();
    super.onClose();
  }


  Future getVideoInfo() async {
    showLoading();
    var response = await HttpService.to.get(url);
    if (response != null) {
      var doc = parse(response.data);
      video = _parseVideoInfo(doc);
      _currentUrl = 'https://v.ddys.pro${video!.videoMeta!.tracks[0].src0}';
      flickManager?.handleChangeVideo(
        VideoPlayerController.networkUrl(Uri.parse(_currentUrl),
            httpHeaders: {'Referer': 'https://ddys.pro/'}),
      );
      updateUi();
    }
    dismissLoading();
  }

  Video _parseVideoInfo(Document doc) {
    var title = doc.querySelector('div.post-content > h1')?.text;
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
    VideoMeta? videoMeta;
    var json = doc
        .querySelector(
            'div.post-content > div.entry > div.wp-playlist.wp-video-playlist.wp-playlist-light.wpse-playlist > script')
        ?.text;
    if (json != null) {
      videoMeta = VideoMeta.fromJson(jsonDecode(json));
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

    var abstractAll = doc
        .querySelector(
            'div.post-content > div.entry > div.doulist-item > div > div > div.abstract')
        ?.innerHtml;
    VideoIntro? videoIntro;
    if (abstractAll != null) {
      List<String> abList = abstractAll.split('<p></p>');
      var intro = abList[1];
      var abs = abList[0].replaceAll('<br>', '\n');
      videoIntro = VideoIntro(post, _title, rating, abs, intro);
    }
    List<Season>? seasonList = [];
    var seasonAll = doc.querySelectorAll(
        '#post-2530 > div.post-content > div.entry > div.page-links >.post-page-numbers');
    for (var child in seasonAll) {
      seasonList.add(Season(
          name: child.text,
          url: child.localName == 'span' ? url : child.attributes['href']!,
          isCurrent: child.localName == 'span'));
    }

    return Video(title, publishDate, updatedDate, categoryList, tagList,
        videoMeta, videoIntro, seasonList);
  }

  void setCurrentTrack(Track track) {
    _currentUrl = 'https://v.ddys.pro${track.src0}';
    flickManager?.handleChangeVideo(
      VideoPlayerController.networkUrl(Uri.parse(_currentUrl),
          httpHeaders: {'Referer': 'https://ddys.pro/'}),
    );
    updateUi();
  }
}
