// ignore: duplicate_ignore
// ignore: file_names, duplicate_ignore
// ignore: file_names
// ignore_for_file: unrelated_type_equality_checks, file_names, unnecessary_null_comparison

import 'dart:io';

import 'package:animated_icon/animated_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/storage_const.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Components/themes/decoration.dart';
import 'package:techblog_project/Controller/filePicker_C.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/Controller/userController/user_C.dart';
import 'package:techblog_project/Services/filePicker_services.dart';
import 'package:techblog_project/gen/assets.gen.dart';
import 'package:techblog_project/Components/constants/strings.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({
    super.key,
  });
  final ThemeController themeController = Get.find();

  final userController = Get.find<UserController>();
  final filepickerController = Get.find<FilePickerController>();
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0))
        .then((value) => userController.getUserInfo());
  }

  @override
  Widget build(BuildContext context) {
    // ! set default text for username when we change profile

    return SafeArea(
      child: Scaffold(
          body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        displacement: 5,
        edgeOffset: 0,
        strokeWidth: 3,
        backgroundColor: MySolidColors.mainColor,
        color: Colors.white,
        onRefresh: _refresh,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Obx(() => userController.loading == false
                ? Stack(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),

                        // !profilePicture
                        Stack(children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: CachedNetworkImage(
                              errorWidget: (context, url, error) {
                                return const Icon(
                                  Icons.image_not_supported_rounded,
                                  color: Colors.grey,
                                  size: 50,
                                );
                              },
                              imageUrl: userController.userModel.value.image
                                  .toString(),
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return loadingSpinKit();
                              },
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MySolidColors.subTitle),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: imageProvider)),
                                );
                              },
                            ),
                          ),
                          Positioned(
                              bottom: 5,
                              right: 2,
                              child: InkWell(
                                onTap: () async {
                                  await pickProfileImagefile();

                                  Future.delayed(const Duration(seconds: 2))
                                      .then(
                                    (value) {
                                      verifydialogImage();
                                    },
                                  );
                                },
                                child: Container(
                                  height: 65,
                                  width: 65,
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MySolidColors.mainColor,
                                    ),
                                    // height: 20,
                                    // width: 20,
                                    child: const Icon(
                                      Icons.add,
                                      size: 25,
                                      color: MySolidColors.scaffoldBack,
                                    ),
                                  ),
                                ),
                              )

                              //  Container(
                              //   decoration: BoxDecoration(
                              //     border: Border.all(
                              //       color: MySolidColors.scaffoldBack,
                              //       width: 1,
                              //     ),
                              //     shape: BoxShape.circle,
                              //     color: MySolidColors.purpleText,
                              //   ),
                              //   height: 50,
                              //   width: 50,
                              //   child: const Icon(
                              //     Icons.add,
                              //     size: 25,
                              //     color: MySolidColors.scaffoldBack,
                              //   ),
                              // ),
                              )
                        ]),

                        const SizedBox(
                          height: 32,
                        ),
                        // !EditUsername
                        GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              titlePadding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              title: MyStr.addUsernameText,
                              titleStyle: Sizes.theme.displayMedium,
                              backgroundColor: MySolidColors.mainColor,
                              radius: 10,
                              content: Container(
                                decoration: LightThemeDecorations
                                    .manageArticleInfoScreentitleUpdate,
                                child: TextField(
                                  controller: userController.name,
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      hintText:
                                          userController.userModel.value.name!,
                                      hintStyle: Sizes.theme.bodyLarge),
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              confirm: ElevatedButton(
                                  onPressed: () async {
                                    // await userController.updateData();

                                    debugPrint(userController.name.text);
                                    Get.back();
                                    // userController.updateData();
                                  },
                                  child: const Text(
                                    MyStr.verify,
                                    style: TextStyle(
                                        fontFamily: "dana",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: MySolidColors.textInPoster),
                                  )),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            height: 50,
                            width: Sizes.size.width / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  color:
                                      themeController.isDarkMode.value == false
                                          ? Colors.black
                                          : Colors.white,
                                  image: Assets.icons.moretext.provider(),
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(MyStr.editUsernameText,
                                    style: TextStyle(
                                        fontFamily: "dana",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            themeController.isDarkMode.value ==
                                                    false
                                                ? Colors.black
                                                : Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // ! Name & Email
                        Column(
                          children: [
                            Text(userController.userModel.value.name!,
                                style: TextStyle(
                                    fontFamily: "dana",
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: themeController.isDarkMode.value ==
                                            false
                                        ? MySolidColors.mainColor
                                        : const Color.fromRGBO(
                                            0, 221, 249, 1))),
                            const SizedBox(
                              height: 32,
                            ),

                            Text(userController.userModel.value.email!,
                                style: TextStyle(
                                    fontFamily: "dana",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: themeController.isDarkMode.value ==
                                            false
                                        ? Colors.black
                                        : Colors.white)),
                            const SizedBox(
                              height: 32,
                            ),
                            const Dividers(),
                            Padding(
                              // !FavArticle
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(RouteScreens
                                      .routeArticleFavoriteListscreen);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimateIcon(
                                      key: UniqueKey(),
                                      onTap: () {},
                                      iconType: IconType.continueAnimation,
                                      width: 20,
                                      color: themeController.isDarkMode.value ==
                                              false
                                          ? Colors.black
                                          : Colors.white,
                                      animateIcon: AnimateIcons.activity,
                                      toolTip: 'صفحه مقالات',
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(MyStr.myLovelyText,
                                        style: TextStyle(
                                            fontFamily: "dana",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: themeController
                                                        .isDarkMode.value ==
                                                    false
                                                ? Colors.black
                                                : Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            const Dividers(),
                            // !FavPodcast
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                      RouteScreens.podcastFavoriteListScreen);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimateIcon(
                                      key: UniqueKey(),
                                      onTap: () {},
                                      iconType: IconType.continueAnimation,
                                      width: 20,
                                      color: themeController.isDarkMode.value ==
                                              false
                                          ? Colors.black
                                          : Colors.white,
                                      animateIcon: AnimateIcons.heart,
                                      toolTip: 'صفحه مقالات',
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(MyStr.myLovelyPodcast,
                                        style: TextStyle(
                                            fontFamily: "dana",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: themeController
                                                        .isDarkMode.value ==
                                                    false
                                                ? Colors.black
                                                : Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            const Dividers(),
                            // !LogOut
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: InkWell(
                                onTap: () {
                                  userController.logOut();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimateIcon(
                                      key: UniqueKey(),
                                      onTap: () {},
                                      iconType: IconType.continueAnimation,
                                      width: 20,
                                      color: themeController.isDarkMode.value ==
                                              false
                                          ? Colors.black
                                          : Colors.white,
                                      animateIcon: AnimateIcons.settings,
                                      toolTip: 'صفحه مقالات',
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(MyStr.logOut,
                                        style: TextStyle(
                                            fontFamily: "dana",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: themeController
                                                        .isDarkMode.value ==
                                                    false
                                                ? Colors.black
                                                : Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            const Dividers(),
                            // !exit
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              child: InkWell(
                                onTap: () {
                                  _restartApp();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimateIcon(
                                      key: UniqueKey(),
                                      onTap: () {},
                                      iconType: IconType.continueAnimation,
                                      width: 20,
                                      color: themeController.isDarkMode.value ==
                                              false
                                          ? Colors.black
                                          : Colors.white,
                                      animateIcon: AnimateIcons.signOut,
                                      toolTip: 'صفحه مقالات',
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(MyStr.exit,
                                        style: TextStyle(
                                            fontFamily: "dana",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: themeController
                                                        .isDarkMode.value ==
                                                    false
                                                ? Colors.black
                                                : Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Sizes.size.height / 6.5,
                            )
                          ],
                        ),
                      ],
                    ),
                    // !save button
                    filepickerController.fileProfileImageData.value.name !=
                                'nothing' &&
                            userController.name.text != null
                        ? Positioned(
                            bottom: 70,
                            left: 60,
                            right: 60,
                            child: ElevatedButton.icon(
                                onPressed: () async {
                                  await userController.updateData();
                                },
                                icon: AnimateIcon(
                                  key: UniqueKey(),
                                  onTap: () {},
                                  iconType: IconType.continueAnimation,
                                  width: 20,
                                  color: Colors.white,
                                  animateIcon: AnimateIcons.upload,
                                  toolTip: 'صفحه مقالات',
                                ),
                                label: const Text(
                                  'آپلود اطلاعات',
                                  style: TextStyle(
                                      fontFamily: "dana",
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(255, 255, 255, 1)),
                                )),
                          )
                        : const SizedBox(
                            height: 5,
                          ),
                  ])
                : GetStorage().read(StorageVariables.token) == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 200),
                            SvgPicture.asset(
                              Assets.images.happytech.toString(),
                              height: Sizes.size.height / 5,
                              width: Sizes.size.width / 2,
                            ),
                            SizedBox(
                              height: Sizes.size.height / 24,
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: 'هنوز ثبت نام نکردی',
                                    style: TextStyle(
                                        fontFamily: "dana",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            themeController.isDarkMode.value ==
                                                    false
                                                ? Colors.black
                                                : Colors.white))),
                          ],
                        ),
                      )
                    : loader()),
          ),
        ),
      )),
    );
  }

// !verifydialogImage
  Future<dynamic> verifydialogImage() {
    return Get.defaultDialog(
      title: '',
      content: Column(
        children: [
          const Text(
            'برای تغییر پروفایل مطمعنی؟',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'dana',
              fontWeight: FontWeight.w300,
              color: MySolidColors.black,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    // userController.updateData();

                    Get.back();
                  },
                  child: const Text(
                    'آره حله',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'dana',
                      fontWeight: FontWeight.w300,
                      color: MySolidColors.scaffoldBack,
                    ),
                  )),
              ElevatedButton(
                  onPressed: () async {
                    filepickerController.fileProfileImageData.value =
                        PlatformFile(name: 'nothing', size: 0);

                    Get.back();
                    await pickProfileImagefile();
                  },
                  child: const Text(
                    'تعویض تصویر',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'dana',
                      fontWeight: FontWeight.w300,
                      color: MySolidColors.scaffoldBack,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  void _restartApp() {
    if (Platform.isAndroid || Platform.isIOS) {
      exit(0); // Exit the app on Android or iOS
    } else {
      throw UnsupportedError(
          'Restarting the app is not supported on this platform.');
    }
  }
}
