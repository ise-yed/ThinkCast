// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/Components/constants/api_constant.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/command_constant.dart';
import 'package:techblog_project/Components/constants/storage_const.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Model/articleModels/article_Model.dart';
import 'package:techblog_project/Model/tags_model.dart';
import 'package:techblog_project/Services/dio_services.dart';

class ArticleFavoriteInfoController extends GetxController {
  Rx<ArticleModel> articleInfoList = ArticleModel().obs;
  RxList<ArticleModel> articleRelatedList = RxList();
  RxList<TagsModel> articleInfoTagsList = RxList();
  RxBool loading = false.obs;
  RxBool isFavoriteUI = true.obs;
  RxString favID = RxString('');
  var userID = GetStorage().read(StorageVariables.userId);

  @override
  void onInit() {
    debugPrint("object ArticleInfoController");
    super.onInit();
  }

  getArticleInfo(String id) async {
    loading.value = true;
    // ignore: prefer_typing_uninitialized_variables
    var userId;
    var response = await DioService().getMethod(
        '${ApiConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userId');
    debugPrint(response.data.toString());

    if (await response.statusCode == 200) {
      articleInfoList.value = (ArticleModel.fromJson(response.data['info']));
      articleRelatedList.clear();
      response.data['related'].forEach((element) {
        articleRelatedList.add(ArticleModel.fromJson(element));
      });
      articleInfoTagsList.clear();
      response.data['tags'].forEach((element) {
        articleInfoTagsList.add(TagsModel.fromJson(element));
      });
   
      Get.toNamed(RouteScreens.routeArticleFavoriteInfoscreen);
    }
    loading.value = false;
  }

  deleteFavotireArticle() async {
    Map<String, dynamic> map = {
      ApiKeyConstant.fav_id: favID.value,
      ApiKeyConstant.user_id: userID,
      ApiKeyConstant.command: CommandConstant.delete_favorite
    };
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}article/post.php', map);

    debugPrint('im up store favorite');
    debugPrint(response.data.toString());
    if (response.data['status_code'] == 200) {
      Get.snackbar(MyStr.infoArticleScreenBookMarkSnackbar,
          MyStr.infoArticleScreenBookMarkSuccessSnackbarText,
          animationDuration: const Duration(seconds: 1),
          forwardAnimationCurve: Curves.linearToEaseOut,
          backgroundColor: MySolidColors.mainColor,
          colorText: MySolidColors.scaffoldBack);

      isFavoriteUI.value = false;
    } else {
      Get.snackbar(MyStr.infoArticleScreenBookMarkSnackbar,
          MyStr.infoArticleScreenBookMarkSupportSnackbarText,
          animationDuration: const Duration(seconds: 1),
          forwardAnimationCurve: Curves.linearToEaseOut,
          backgroundColor: MySolidColors.mainColor,
          colorText: MySolidColors.scaffoldBack);
    }
  }
}
