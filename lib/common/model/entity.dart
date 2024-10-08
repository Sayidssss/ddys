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

class Article {
  String name;
  String url;
  String pic;
  String? remark;
  List<Category> categories;

  Article(this.name, this.url, this.pic, this.remark, this.categories);
}

class Video {
  Stream name;
  List<Category> categories;
  List<Tag> tags;
  Video(this.name, this.categories, this.tags);
}

class VideoIntro {
  String? post;
  String? title;
  String? rating;
  String? abstract;
  String? intro;
  VideoIntro(this.post, this.title, this.rating, this.abstract, this.intro);
}
