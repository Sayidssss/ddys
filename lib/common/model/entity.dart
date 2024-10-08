class Category {
  String name;
  String url;

  Category({
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
