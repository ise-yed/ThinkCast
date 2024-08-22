// ignore_for_file: file_names, non_constant_identifier_names, non_constant_identifier_names, non_constant_identifier_names, non_constant_identifier_names, duplicate_ignore, prefer_interpolation_to_compose_strings


class ArticleModel {
  String? id;
  String? title;
  String? image;
  String? catId;
  String? catName;
  String? author;
  String? view;
  String? status;
  String? content;
  String? createdAt;
  bool? isFavorite;
  String? fav_id;
  String? beforeImage;
  // ignore: non_constant_identifier_names
  String? article_id;

// !add isfavorite
  ArticleModel({
    this.title,
    this.image,
    this.content,
  });
  ArticleModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    title = element['title'];
    author = element['author'];
    catId = element['cat_id'];
    catName = element['cat_name'];
    createdAt = element['created_at'];
    status = element['status'];
    view = element['view'];
    content = element['content'];
    isFavorite = element['isFavorite'];

    view = element['view'];
    fav_id = element['fav_id'];
    article_id = element['article_id'];

    image = 'https://thinkcast.ir' + element['image'];
  }
}
