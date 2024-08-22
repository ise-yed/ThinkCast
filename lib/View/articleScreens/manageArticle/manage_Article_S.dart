// ignore_for_file: file_names

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Controller/article_controller/articleInfo_C.dart';
import 'package:techblog_project/Controller/article_controller/manageArticle_C.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Components/constants/strings.dart';
// import 'package:animated_icon/animated_icon.dart';

class ManageArtiScreen extends StatelessWidget {
  ManageArtiScreen({super.key});
  final manageArticleController = Get.find<ManageArticleController>();
  final articlecontroller = Get.find<ArticleInfoController>();
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0))
        .then((value) => manageArticleController.getDataManageArticle());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: listsAppbar(appbarText: MyStr.manageArticleListText),
        body: Obx(
          () =>
              // manageArticleController.loading.value == true?loadingSpinKit():
              manageArticleController.articleList.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(right: Sizes.widthsize),
                      child: RefreshIndicator(
                        triggerMode: RefreshIndicatorTriggerMode.onEdge,
                        displacement: 5,
                        edgeOffset: 0,
                        strokeWidth: 3,
                        backgroundColor: MySolidColors.mainColor,
                        color: Colors.white,
                        onRefresh: _refresh,
                        child: ListView.builder(
                          itemCount: manageArticleController.articleList.length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                articlecontroller.getArticleInfo(
                                    manageArticleController
                                        .articleList[index].id!);
                                //! check id
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: Sizes.widthsize),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    listsImage(
                                        index: index,
                                        controller: manageArticleController
                                            .articleList[index].image
                                            .toString()),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: Sizes.size.width / 1.7,
                                      child: Column(
                                        children: [
                                          Text(
                                            manageArticleController
                                                .articleList[index].title!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: "dana",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: themeController
                                                            .isDarkMode.value ==
                                                        false
                                                    ? Colors.black
                                                    : Colors.white),
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          SizedBox(
                                            height: Sizes.size.height / 28,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Row(
                                                children: [
                                                  AnimateIcon(
                                                    key: UniqueKey(),
                                                    onTap: () {
                                                      debugPrint(
                                                          'delete id is');
                                                      debugPrint(
                                                          manageArticleController
                                                              .articleList[
                                                                  index]
                                                              .id!);
                                                      manageArticleController
                                                          .deleteArticle(
                                                              manageArticleController
                                                                  .articleList[
                                                                      index]
                                                                  .id!);

                                                                  manageArticleController.getDataManageArticle();
                                                    },
                                                    iconType: IconType
                                                        .continueAnimation,
                                                    height: 40,
                                                    color: Colors.red,
                                                    animateIcon:
                                                        AnimateIcons.trashBin,
                                                    toolTip: 'صفحه مقالات',
                                                  ),
                                                  AnimateIcon(
                                                    key: UniqueKey(),
                                                    onTap: () {
                                                      Get.toNamed(
                                                        RouteScreens
                                                            .routeManageArticleInfoEditScreen,
                                                      );
                                                      manageArticleController
                                                          .getArticleInfo(
                                                              manageArticleController
                                                                  .articleList[
                                                                      index]
                                                                  .id!);

                                                      manageArticleController
                                                              .titletextEditingController
                                                              .text =
                                                          manageArticleController
                                                              .articleList[
                                                                  index]
                                                              .title!;
                                                    },
                                                    iconType: IconType
                                                        .continueAnimation,
                                                    height: 50,
                                                    color: themeController
                                                                .isDarkMode
                                                                .value ==
                                                            false
                                                        ? Colors.black
                                                        : Colors.white,
                                                    animateIcon:
                                                        AnimateIcons.edit,
                                                    toolTip: 'صفحه مقالات',
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                " بازدید ${manageArticleController.articleList[index].view!}",
                                                style: TextStyle(
                                                    fontFamily: "dana",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                    color: themeController
                                                                .isDarkMode
                                                                .value ==
                                                            false
                                                        ? Colors.black
                                                        : Colors.white),
                                              ),
                                            ],
                                          ),
                                          // Text(
                                          //   manageArticleController
                                          //       .articleList[index].catName!,
                                          //   style: Sizes.theme.labelSmall,
                                          // )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  :
                  // !while data not get
                  // !EmptyState
                  emptyState(),
        ),
        bottomNavigationBar:
            // !Managebutton
            managebutton(),
      ),
    );
  }

// ! Managebutton
  Padding managebutton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
      child: SizedBox(
        height: Get.height / 14,
        width: Get.width / 2,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)))),
          onPressed: () {
            manageArticleController.clearVariables();

            Get.toNamed(RouteScreens.manageArticleInfoScreen);
          },
          child: const Text(
            MyStr.manageArticleEmptyStateButtonText,
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
