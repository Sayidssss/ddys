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
  String key;
  int season;
  String? publishDate;
  String? updateDate;
  List<Category>? categories;
  List<Tag>? tags;
  VideoMeta? videoMeta;
  VideoIntro? videoIntro;
  List<Season> seasons;
  Video(
      this.key,
      this.name,
      this.season,
      this.publishDate,
      this.updateDate,
      this.categories,
      this.tags,
      this.videoMeta,
      this.videoIntro,
      this.seasons);
}

class VideoIntro {
  String? post;
  String? title;
  String? rating;
  String? abstract;
  String? intro;
  VideoIntro(this.post, this.title, this.rating, this.abstract, this.intro);
}

class History {
  String videoKey;
  String name;
  String url;
  String img;
  int season;
  int eps;
  History({
    required this.videoKey,
    required this.name,
    required this.url,
    required this.img,
    required this.season,
    required this.eps,
  });

  factory History.fromMap(Map<String, dynamic> json) {
    return History(
      videoKey: json["video_key"],
      name: json["name"],
      url: json["url"],
      img: json["img"],
      season: json["season"],
      eps: json["eps"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "video_key": videoKey,
      "name": name,
      "url": url,
      "img": img,
      "season": season,
      "eps": eps,
    };
  }

//
}
