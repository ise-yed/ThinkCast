// ignore_for_file: file_names, non_constant_identifier_names, duplicate_ignore

import 'package:techblog_project/Components/constants/api_constant.dart';

class PodcastModel {
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
  // ignore: non_constant_identifier_names
  String? fav_id;
  String? podcast_id;
  String? beforeImage;
PodcastModel(
  // this.id,
  // this.title,
  // this.poster,
  // this.catName,
  // this.author,
  // this.view,
  // this.status,
  // this.createdAt,
  // this.publisher,
  // this.isFavorite,
  // this.fav_id,
  // this.podcast_id,
);
  PodcastModel.fromjson(Map<String, dynamic> element) {
    id = element["id"];
    title = element["title"];
    poster =ApiConstant.imageBaseUrl +element['poster'];

    catName = element["cat_name"];
    author = element["author"];
    view = element["view"];
    status = element["status"];
    createdAt = element["created_at"];
    publisher = element["publisher"];
    isFavorite = element["isFavorite"];
    fav_id = element["fav_id"];
    podcast_id = element["podcast_id"];
  }
}
