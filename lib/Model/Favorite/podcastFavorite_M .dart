// ignore_for_file: file_names, non_constant_identifier_names

import 'package:techblog_project/Components/constants/api_constant.dart';

class PodcastFavoriteModel {
  String? id;
  String? title;
  String? poster;
  String? catName;
  String? author;
  String? view;
  String? status;
  String? createdAt;
  String? publisher;
  bool? isFavorite;

  PodcastFavoriteModel.fromjson(Map<String, dynamic> element) {
    id = element["id"];
    title = element["title"];
    poster = ApiConstant.imageBaseUrl + element['poster'];
    catName = element["cat_name"];
    author = element["author"];
    view = element["view"];
    status = element["status"];
    createdAt = element["created_at"];
    publisher = element["publisher"];
    isFavorite = element["isFavorite"];
  }
}
