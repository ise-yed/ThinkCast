// ignore_for_file: file_names

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon_animated/icon_animated.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Components/themes/decoration.dart';
import 'package:techblog_project/Controller/article_controller/manageArticle_C.dart';
import 'package:techblog_project/Controller/filePicker_C.dart';
import 'package:techblog_project/Controller/homeScreenController/homeScreen_C.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/Services/filePicker_services.dart';

import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/View/articleScreens/manageArticle/html_Content_Editor_S.dart';
import 'package:techblog_project/gen/assets.gen.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ManageArticleInfoScreen extends StatelessWidget {
  ManageArticleInfoScreen({super.key});

  final manageArticleController = Get.find<ManageArticleController>();
  // todo:bad performance
  final filepickerController = Get.find<FilePickerController>();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Obx(() => Column(
                  children: [
                    // !IArticleImage
                    SizedBox(
                      height: Sizes.size.height / 3.03,
                      width: Sizes.size.width,
                      child: Stack(
                        children: [
                          storePosterImage(controller: filepickerController),
                          // ! manageArticleInfoScreenAppBar
                          manageArticleInfoScreenAppBar(
                              manageArticleController: manageArticleController),
                          // ! filePickerButton
                          filePickerButton(),
                        ],
                      ),
                    ),
                    Column(
                      children: showSelectedCats,
                    )
                  ],
                ))),
        bottomNavigationBar: finishButton(),
      ),
    );
  }

  List<Widget> get showSelectedCats {
    return [
      SizedBox(
        height: Sizes.widthsize,
      ),
      // ! ArticleEditText
      articleEditText(),
      SizedBox(
        height: Sizes.widthsize,
      ),
      Text(
        manageArticleController.articleInfoList.value.title!,
        style: TextStyle(
            fontFamily: "dana",
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: themeController.isDarkMode.value == false
                ? Colors.black
                : Colors.white),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textDirection: TextDirection.rtl,
      ),
      SizedBox(
        height: Sizes.widthsize,
      ),
      // ! MainArticleEditText
      mainArticleEditText(),
      SizedBox(
        height: Sizes.widthsize,
      ),
      manageArticleController.articleInfoList.value.content == null
          // ignore: prefer_const_constructors
          ? Text(
              'بدون بدنه',
            )
          : Padding(
              padding: EdgeInsets.only(
                  right: Sizes.widthsize, left: Sizes.widthsize),
              child: HtmlWidget(
                manageArticleController.articleInfoList.value.content!,
                onLoadingBuilder: (context, element, loadingProgress) {
                  return loadingSpinKit();
                },
                textStyle: TextStyle(
                    fontFamily: "dana",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: themeController.isDarkMode.value == false
                        ? Colors.black
                        : Colors.white),
              ),
            ),
      SizedBox(
        height: Sizes.widthsize,
      ),
      // ! selectCatEditText
      selectCatEditText(),

      // todo: just a show one not a list
// !SelectedCats
      selectedCats(),
    ];
  }

// !SelectedCats
  SizedBox selectedCats() {
    return SizedBox(
      height: Sizes.size.height / 4,
      width: Sizes.size.width,
      child: ListView.builder(
        itemCount: manageArticleController.selectCatList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            child: Container(
              width: 120,
              height: 45,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurRadius: 1.5, color: MySolidColors.mainColor)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: MySolidColors.mainColor),
              child:
                  // !selected cats text
                  Center(
                child: Text(
                  manageArticleController.selectCatList[index].title!,
                  style: Sizes.theme.headlineMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

// !titleUpdate
  titleUpdate() {
    Get.defaultDialog(
        backgroundColor: MySolidColors.mainColor,
        title: MyStr.titleArticleEditText,
        titleStyle: Sizes.theme.displayMedium,
        content: Container(
          decoration: LightThemeDecorations.manageArticleInfoScreentitleUpdate,
          child: TextField(
            controller: manageArticleController.titletextEditingController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              hintText: MyStr.writeArticleEditText,
            ),
            style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.text,
          ),
        ),
        radius: 15,
        confirm: ElevatedButton(
            onPressed: () {
              manageArticleController.newArticletitleUpdate();
              Get.back();
            },
            child: const Text(
              MyStr.verify,
              style: TextStyle(
                  fontFamily: "dana",
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: MySolidColors.textInPoster),
            )));
  }

// ! filePickerButton
  Positioned filePickerButton() {
    return Positioned(
        bottom: 15,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            width: Sizes.size.width / 3,
            height: Sizes.size.height / 22,
            decoration:
                LightThemeDecorations.manageArticleInfoScreenfilePickerButton,
            child: GestureDetector(
              onTap: () async {
                await pickImagefile();
                filepickerController.fileImageData.value.name != 'nothing'
                    ? verifydialogImage()
                    : null;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    MyStr.selectImage,
                    style: Sizes.theme.headlineMedium,
                  ),
                  const IconAnimated(
                    color: Colors.white,
                    active: true,
                    size: 40,
                    iconType: IconType.add,
                  ),

                  // const Icon(
                  //   Icons.add,
                  //   color: MySolidColors.scaffoldBack,
                  //   size: 25,
                  // )
                ],
              ),
            ),
          ),
        ));
  }

// ! verifydialogImage
  Future<dynamic> verifydialogImage() {
    return Get.defaultDialog(
      title: '',
      content: Column(
        children: [
          Text(
            'مطمعنی میخوای تصویر رو تغییر بدی؟',
            style: Sizes.theme.bodyLarge,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    Get.back();
                  },
                  child: const Text(
                    'آره حله',
                    style: TextStyle(
                        fontFamily: "dana",
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: MySolidColors.scaffoldBack),
                  )),
              ElevatedButton(
                  onPressed: () {
                    filepickerController.fileImageData.value =
                        PlatformFile(name: 'nothing', size: 0);
                    Get.back();
                  },
                  child: const Text('نه بیخیال',
                      style: TextStyle(
                          fontFamily: "dana",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: MySolidColors.scaffoldBack))),
            ],
          )
        ],
      ),
    );
  }

  // ! MainArticleEditText
  Padding mainArticleEditText() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, Sizes.widthsize, 0),
      child: Row(
        children: [
          Image(
            image: Assets.icons.moretext.provider(),
            height: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () => Get.to(BodyTextEditor()),
            child: Text(
              MyStr.mainArticleEditText,
              style: Sizes.theme.displayLarge,
            ),
          ),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }

// !  ArticleEditText
  Padding articleEditText() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, Sizes.widthsize, 0),
      child: Row(
        children: [
          Image(
            image: Assets.icons.moretext.provider(),
            height: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () => titleUpdate(),
            child: Text(
              MyStr.articleEditText,
              style: TextStyle(
                  fontFamily: "dana",
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: themeController.isDarkMode.value == false
                      ? const Color.fromRGBO(0, 59, 100, 1)
                      : const Color.fromRGBO(0, 221, 249, 1)),
            ),
          ),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }

// manageArticleController.articleInfoList.value.image!
  // ! selectCatEditText
  Padding selectCatEditText() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, Sizes.widthsize, 0),
      child: InkWell(
        onTap: () => chooseCatsBottomSheet(),
        child: Row(
          children: [
            Image(
              image: Assets.icons.moretext.provider(),
              height: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              MyStr.selectCatEditText,
              style: Sizes.theme.displayLarge,
            ),
            const SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }

// !chooseCatsBottomSheet
  chooseCatsBottomSheet() {
    var homeScreenController = Get.find<HomeScreenController>();
    Get.bottomSheet(
        persistent: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        Container(
          height: Sizes.size.height / 1.6,
          decoration: LightThemeDecorations.manageArticleInfoScreenbottomSheet,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(
                height: Sizes.widthsize,
              ),
              Text(
                MyStr.completeSignupCategoryText,
                style: Sizes.theme.titleLarge,
              ),
              SizedBox(
                height: Sizes.widthsize,
              ),
              SizedBox(
                height: Sizes.size.height / 1.9,
                // !cats
                child: GridView.builder(
                  itemCount: homeScreenController.tagsList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (manageArticleController.selectCatIdList.length <
                            3) {
                          manageArticleController.selectCatList
                              .add(homeScreenController.tagsList[index]);
                          manageArticleController.selectCatIdList
                              .add(homeScreenController.tagsList[index].id);

                          debugPrint(manageArticleController.selectCatIdList
                              .toString());
                        } else {
                          Get.snackbar('خطا', 'فقط میتونی 3 تا انتخاب کنی',
                              animationDuration: const Duration(seconds: 1),
                              forwardAnimationCurve: Curves.linearToEaseOut,
                              backgroundColor: MySolidColors.mainColor,
                              colorText: MySolidColors.scaffoldBack);
                        }

                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 65,
                          width: 100,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: MySolidColors.articleInfoTagsBack),
                          child: Center(
                            child: Text(
                              homeScreenController.tagsList[index].title!,
                              style: Sizes.theme.displayMedium,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ]),
          ),
        ));
  }

// !FinishButton
  Padding finishButton() {
    return Padding(
      padding: EdgeInsets.only(
          left: Sizes.size.width / 15,
          right: Sizes.size.width / 15,
          bottom: 10,
          top: 20),
      child: SizedBox(
        height: Get.height / 14,
        width: Get.width / 2,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)))),
          onPressed: () async {
            await manageArticleController.storeArticle();
            manageArticleController.getDataManageArticle();
            Get.offAllNamed(RouteScreens.routeSplashScreen);
          },
          child: const Text(
            MyStr.finishedButtonText,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'dana',
              fontWeight: FontWeight.w300,
              color: MySolidColors.scaffoldBack,
            ),
          ),
        ),
      ),
    );
  }
}
