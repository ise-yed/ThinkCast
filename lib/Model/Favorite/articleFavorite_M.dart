// ignore_for_file: file_names, non_constant_identifier_names

import 'package:techblog_project/Components/constants/api_constant.dart';

class ArticleFavoriteModel {
  String? fav_id;
  String? article_id;
  String? title;
  String? image;
  String? cat_id;
  String? cat_name;
  String? author;
  String? view;
  String? status;
  String? created_at;

  ArticleFavoriteModel.fromJson(Map<String, dynamic> element) {
    fav_id = element['fav_id'];
    article_id = element['article_id'];
    title = element['title'];
    image = ApiConstant.imageBaseUrl + element['image'];
    cat_id = element['cat_id'];
    author = element['author'];
    view = element['view'];
    status = element['status'];
    created_at = element['created_at'];
  }
}
