// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/Components/constants/storage_const.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Model/articleModels/article_Model.dart';
import 'package:techblog_project/Services/dio_services.dart';

class ArticleListController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  // RxList<ArticleModel> articleLowList = RxList();
  RxBool homeScreenLoading = false.obs;
  RxString appBarText = MyStr.minArticleListAppbarText.obs;
  var userID = GetStorage().read(StorageVariables.userId);
    RxInt toggleState = 0.obs;

  @override
  onInit() {
    super.onInit();
    getArticleHighListData();
    debugPrint("object ArticleListController");
  }

  getArticleHighListData() async {
    articleList.clear();
    homeScreenLoading.value = true;
    var response = await DioService().getMethod(
        'https://thinkcast.ir/api/article/get.php?command=new&user_id=1');
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });


    }
  }



  //   getArticleLowListData() async {
  //   articleLowList.clear();
  //   homeScreenLoading.value = true;
  //   var response = await DioService().getMethod(
       
  //       'https://thinkcast.ir/api/article/get.php?command=new&user_id=1');
  //   if (response.statusCode == 200) {

  //     response.data.forEach((element) {
  //       articleLowList.add(ArticleModel.fromJson(element));
  //     });


  //   }
  // }

  getArticleListWithTagsId(String id) async {
    articleList.clear();
    homeScreenLoading.value = true;
    var response = await DioService().getMethod(
    
    'https://thinkcast.ir/api/article/get.php?command=new&user_id=');
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });

      Get.toNamed(RouteScreens.routeArticleListScreen);
    }
  }
}
