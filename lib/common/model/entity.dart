import 'package:ddys/common/model/video.dart';

class Category {
  String name;
  String url;

  Category({
    required this.name,
    required this.url,
  });
}

class Tag {
  String name;
  String url;

  Tag({
    required this.name,
    required this.url,
  });
}

class Season {
  String name;
  String url;
  bool isCurrent;

  Season({
    required this.name,
    required this.url,
    required this.isCurrent,
  });
}

class Article {
  String name;
  String latest;
  String url;
  String pic;
  String? remark;
  List<Category> categories;

  Article(
      this.name, this.latest, this.url, this.pic, this.remark, this.categories);
}

class Video {
  String? name;
  String? publishDate;
  String? updateDate;
  List<Category>? categories;
  List<Tag>? tags;
  VideoMeta? videoMeta;
  VideoIntro? videoIntro;
  List<Season> seasons;
  Video(this.name, this.publishDate, this.updateDate, this.categories,
      this.tags, this.videoMeta, this.videoIntro, this.seasons);
}

class VideoIntro {
  String? post;
  String? title;
  String? rating;
  String? abstract;
  String? intro;
  VideoIntro(this.post, this.title, this.rating, this.abstract, this.intro);
}
