// ignore: file_names
// ignore_for_file: non_constant_identifier_names, duplicate_ignore, file_names

import 'package:techblog_project/Components/constants/api_constant.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? image;
  String? token;
  String? create_at;
  UserModel({
    this.id,
       this.name,
          this.email,
             this.image,
                this.token,
                   // ignore: non_constant_identifier_names
                   this.create_at,

  });
  UserModel.fromJson(Map<String, dynamic> element) {
    id = element['id'];
    name = element['name'];
    email = element['email'];
    image = ApiConstant.imageBaseUrl+element['image'];
    token = element['token'];
    create_at = element['create_at'];
  }
}
