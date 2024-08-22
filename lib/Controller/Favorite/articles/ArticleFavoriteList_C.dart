// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/Components/constants/api_constant.dart';
import 'package:techblog_project/Components/constants/storage_const.dart';
import 'package:techblog_project/Model/Favorite/articleFavorite_M.dart';
import 'package:techblog_project/Services/dio_services.dart';

class ArticleFavoriteListController extends GetxController {
  RxList<ArticleFavoriteModel> articleFavoriteList = RxList();
  var userId = GetStorage().read(StorageVariables.userId);

  @override
  void onInit() {
    super.onInit();
    debugPrint(('im from ArticleFavoriteController'));
    getArticleFavoriteData();
  }

  getArticleFavoriteData() async {
    articleFavoriteList.clear();
    var response = await DioService().getMethod(
              '${ApiConstant.baseUrl}article/get.php?command=favorites&user_id=$userId');

      
    debugPrint(response.data.toString());
    if (await response.statusCode == 200) {
      for (var element in response.data) {
        articleFavoriteList.add(ArticleFavoriteModel.fromJson(element));
      }
    }
  }
}
