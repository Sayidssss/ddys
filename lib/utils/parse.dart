import 'package:ddys/common/model/entity.dart';
import 'package:html/dom.dart';

List<Article> parseArticleList(List<Element> list) {
  return list.map((a) {
    var url = a.attributes['data-href']!;
    var container = a.querySelector('div.post-box-image');
    String bg = container!.attributes['style']!;
    var pic = bg.substring(bg.indexOf("https://"), bg.indexOf(")"));
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
