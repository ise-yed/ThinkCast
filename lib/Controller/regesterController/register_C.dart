// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/constants/api_constant.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Components/constants/storage_const.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/Controller/userController/user_C.dart';
import 'package:techblog_project/Services/dio_services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/View/mainPages/main_S.dart';
import 'package:techblog_project/gen/assets.gen.dart';

class RegesterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activateEditingController = TextEditingController();
  RxString userId = RxString('');
  RxBool isValidEmail = false.obs;
  final themeController = Get.find<ThemeController>();
  final userController = Get.put(UserController());

  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register',
    };
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}register/action.php', map);
    userId.value = response.data['user_id'];
    debugPrint(response);
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'user_id': userId.value,
      'code': activateEditingController.text,
      'command': 'verify'
    };
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}register/action.php', map);
    var status = response.data['response'];
    switch (status) {
      case 'verified':
        var box = GetStorage();
        box.write(StorageVariables.token, response.data['token']);
        box.write(StorageVariables.userId, response.data['user_id']);
        debugPrint(box.read(StorageVariables.token));
        debugPrint(box.read(StorageVariables.userId));
        userController.userID = response.data['user_id'];
        selectedPageIndex.value = 0;
        selectedPageState.value = 0;
        Get.back();
        Get.back();

        break;
      case 'incorrect_code':
        Get.snackbar('خطا', 'کد اشتباه است',
            animationDuration: const Duration(seconds: 1),
            forwardAnimationCurve: Curves.linearToEaseOut,
            backgroundColor: MySolidColors.mainColor,
            colorText: MySolidColors.scaffoldBack);

        break;
      case 'expired':
        Get.snackbar('خطا', 'کد متقضی شده',
            animationDuration: const Duration(seconds: 1),
            forwardAnimationCurve: Curves.linearToEaseOut,
            backgroundColor: MySolidColors.mainColor,
            colorText: MySolidColors.scaffoldBack);
        break;
    }
  }

  emailValidator(String value) {
    value.isEmail ? isValidEmail.value = true : isValidEmail.value = false;
  }

// !Check SignIn Or SignUp
  toggleLogin() {
    GetStorage().read(StorageVariables.token) == null
        ? Get.toNamed(RouteScreens.routeRegisterScreen)
        : regisaterButtomSheet();
  }

// !RegisaterButtomSheet
  regisaterButtomSheet() {
    return Get.bottomSheet(
        backgroundColor: Colors.transparent,
        Container(
          height: Get.height / 3,
          decoration: BoxDecoration(
              color: themeController.isDarkMode.value == false
                  ? Colors.white
                  : Color.fromARGB(255, 1, 10, 24),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Padding(
            padding: EdgeInsets.only(top: 24, bottom: 24, left: 24, right: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.images.happytech.toString(),
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(MyStr.registerButtomSheetTitleText,
                        style: TextStyle(
                          fontFamily: "dana",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: themeController.isDarkMode.value == false
                              ? Colors.black
                              : Colors.white,
                        ))
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
              
                InkWell(
                  onTap: () =>
                      Get.toNamed(RouteScreens.routeManageArticleScreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(MyStr.manageArticleListText,
                          style: TextStyle(
                            fontFamily: "dana",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: themeController.isDarkMode.value == false
                                ? Colors.black
                                : Colors.white,
                          )),
                      const SizedBox(
                        width: 12,
                      ),
                      Image.asset(
                        color: themeController.isDarkMode.value == false
                            ? Colors.black
                            : Colors.white,
                        Assets.images.manageArticle.path,
                        height: 45,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Divider(
                  thickness: 2,
                  color: themeController.isDarkMode.value == false
                      ? Colors.black
                      : Colors.white,
                  endIndent: 100,
                  indent: 100,
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () =>
                      Get.toNamed(RouteScreens.routeManagePodcastListScreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(MyStr.managePodcastListText,
                          style: TextStyle(
                            fontFamily: "dana",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: themeController.isDarkMode.value == false
                                ? Colors.black
                                : Colors.white,
                          )),
                      const SizedBox(
                        width: 12,
                      ),
                      Image.asset(
                        color: themeController.isDarkMode.value == false
                            ? Colors.black
                            : Colors.white,
                        Assets.images.managePodcasts.path,
                        height: 45,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
