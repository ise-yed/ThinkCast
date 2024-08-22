// ignore_for_file: file_names

import 'package:techblog_project/Components/constants/api_constant.dart';

class PosterModel {
  String? id;
  String? title;
  String? image;
  PosterModel({
     this.id,
     this.title,
     this.image,
  });

  PosterModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    title = element['title'];
    image = ApiConstant.imageBaseUrl+element['image'];
  }
}
