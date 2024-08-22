// ignore_for_file: file_names, avoid_print

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/Components/constants/api_constant.dart';
import 'package:techblog_project/Components/constants/command_constant.dart';

import 'package:techblog_project/Components/constants/storage_const.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Controller/filePicker_C.dart';
import 'package:techblog_project/Model/articleModels/article_Model.dart';
import 'package:techblog_project/Model/tags_model.dart';
import 'package:techblog_project/Services/dio_services.dart';
import 'package:dio/dio.dart' as dios;

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  Rx<ArticleModel> articleInfoList = ArticleModel(
    content: MyStr.contentDefaultText,
    title: MyStr.titleDefaultText,
  ).obs;
  Rx<ArticleModel> articleInfoEditList = ArticleModel().obs;

  TextEditingController titletextEditingController = TextEditingController();

  RxList<TagsModel> selectCatList = RxList();
  RxList selectCatIdList = RxList();
  var userID = GetStorage().read(StorageVariables.userId);
  final filepickerController = Get.find<FilePickerController>();
  RxBool loading = false.obs;
  RxString defaultImage = RxString('');
  @override
  void onInit() async {
    super.onInit();
    await getDataManageArticle();
  }

  getDataManageArticle() async {
    articleList.clear();
    var response = await DioService().getMethod(
        '${ApiConstant.baseUrl}article/get.php?command=published_by_me&user_id=$userID');

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
    }

    print(articleList[0].image);
    print(articleList[1].image);
    print(articleList[2].image);
  }

  getArticleInfo(String id) async {
    loading.value = true;
    // ignore: prefer_typing_uninitialized_variables
    var response = await DioService().getMethod(
        '${ApiConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userID');
    if (await response.statusCode == 200) {
      articleInfoEditList.value =
          (ArticleModel.fromJson(response.data['info']));
    }
    response.data['tags'].forEach((element) {
      selectCatList.add(TagsModel.fromJson(element));
      selectCatIdList.add(element['id']);
    });
    defaultImage.value = articleInfoEditList.value.image!;
    print(defaultImage.value);
    print(selectCatIdList);
    loading.value = false;
  }

  newArticletitleUpdate() {
    articleInfoList.update((val) {
      val!.title = titletextEditingController.text;
    });
  }

  editArticletitleUpdate() {
    articleInfoEditList.update((val) {
      val!.title = titletextEditingController.text;
    });
  }

  storeEditArticle() async {
    var fileController = Get.find<FilePickerController>();
    Map<String, dynamic> map = {
      ApiKeyConstant.article_id: articleInfoEditList.value.id,
      ApiKeyConstant.title: articleInfoEditList.value.title,
      ApiKeyConstant.content: articleInfoEditList.value.content,
      ApiKeyConstant.cat_id: '3',
      ApiKeyConstant.tag_list: '$selectCatIdList',
      ApiKeyConstant.user_id: userID,
      ApiKeyConstant.image: fileController.fileImageData.value.name == 'nothing'
          ? defaultImage.value
          : await dios.MultipartFile.fromFile(
              fileController.fileImageData.value.path!),
      ApiKeyConstant.command: "update",
    };
    var response = await DioService().postMethod(
      '${ApiConstant.baseUrl}article/post.php',
      map,
    );
    debugPrint(response.data.toString());
  }

// !storeArticle in info screen
  storeArticle() async {
    var fileController = Get.find<FilePickerController>();
    debugPrint(selectCatIdList.toString());
    Map<String, dynamic> map = {
      ApiKeyConstant.title: articleInfoList.value.title,
      ApiKeyConstant.content: articleInfoList.value.content,
      ApiKeyConstant.cat_id: '1',
      ApiKeyConstant.tag_list: '$selectCatIdList',
      ApiKeyConstant.user_id: userID,
      // GetStorage().read(StorageVariables.userId),
      ApiKeyConstant.image: await dios.MultipartFile.fromFile(
          fileController.fileImageData.value.path!),
      ApiKeyConstant.command: "store",
    };
    var response = await DioService().postMethod(
      '${ApiConstant.baseUrl}article/post.php',
      map,
    );
    debugPrint(response.data.toString());
  }

  deleteArticle(String id) async {
    Map<String, dynamic> map = {
      ApiKeyConstant.article_id: id,
      ApiKeyConstant.user_id: userID,
      ApiKeyConstant.command: CommandConstant.delete_article
    };
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}article/post.php', map);

    debugPrint(response.toString());
  }

  clearVariables() {
    titletextEditingController.text = '';
    articleInfoList.value.title = MyStr.titleDefaultText;
    articleInfoList.value.content = MyStr.contentDefaultText;

    filepickerController.fileImageData.value =
        PlatformFile(name: 'nothing', size: 0);
    selectCatIdList = [].obs;
    selectCatList = RxList();
  }
}
