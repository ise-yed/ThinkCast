// ignore_for_file: file_names, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/Components/constants/api_constant.dart';
import 'package:techblog_project/Components/constants/storage_const.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Controller/filePicker_C.dart';
import 'package:techblog_project/Model/user/user_M.dart';
import 'package:techblog_project/Services/dio_services.dart';
import 'package:dio/dio.dart' as dios;
import 'package:techblog_project/View/mainPages/main_S.dart';

class UserController extends GetxController {
  Rx<UserModel> userModel = UserModel().obs;
  RxBool loading = false.obs;
  var userID = GetStorage().read(StorageVariables.userId);
  TextEditingController name = TextEditingController();
  RxBool appbarIconStatus = false.obs;
  var fileController = Get.put(FilePickerController());

  @override
  void onInit() async {
    debugPrint("object UserController");
    appbarTimer();
    await getUserInfo();
    super.onInit();
  }

  appbarTimer() {
    Timer timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      if (appbarIconStatus.value) {
        appbarIconStatus.value = false;
      } else {
        appbarIconStatus.value = true;
      }
    });
  }

  getUserInfo() async {
    loading.value = true;
    var response = await DioService().getMethod(
        'https://thinkcast.ir/api//user/?command=info&user_id=$userID');
    debugPrint(response.data.toString());
    if (await response.statusCode == 200) {
      userModel.value = UserModel.fromJson(response.data['response']);
    }
    name.text = userModel.value.name!;

    loading.value = false;
  }

  updateData() async {
    Map<String, dynamic> map = {
      'name': name.text,
      'image': await dios.MultipartFile.fromFile(
          fileController.fileProfileImageData.value.path!),
      'user_id': userID
    };
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}user/?command=update', map);
    debugPrint(response.toString());
  }

  logOut() {
    GetStorage().remove(StorageVariables.token);
    GetStorage().remove(StorageVariables.userId);
    selectedPageIndex.value = 0;
    selectedPageState.value = 0;
  }

  // !Check SignIn Or SignUp
  toggleLogin() {
    if (GetStorage().read(StorageVariables.token) == null) {
      Get.toNamed(RouteScreens.routeRegisterScreen);
      selectedPageIndex.value = 0;
    } else {
      getUserInfo();
    }
  }
}
