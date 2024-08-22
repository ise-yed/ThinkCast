// ignore_for_file: file_names

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Controller/Podcast_Controller/managePodcast_C.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Controller/homeScreenController/homeScreen_C.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/gen/assets.gen.dart';

class ManagePodcastListScreen extends StatelessWidget {
  ManagePodcastListScreen({super.key});
  final ThemeController themeController = Get.find();
  final homeScreenController = Get.find<HomeScreenController>();

  final managePodcastListController = Get.find<ManagePodcastController>();
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0))
        .then((value) => managePodcastListController.getDataManagePodcasts());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: listsAppbar(appbarText: MyStr.managePodcastListText),
        body: Obx(
          () =>
              managePodcastListController.podcastList.isNotEmpty
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
                          itemCount:
                              managePodcastListController.podcastList.length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed(RouteScreens.routePodcastItemScreen,
                                    arguments: managePodcastListController
                                        .podcastList[index]);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: Sizes.widthsize),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // ! image
                                    listsImage(
                                        index: index,
                                        controller: managePodcastListController
                                            .podcastList[index].poster
                                            .toString()),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: Sizes.size.width / 1.7,
                                      child: Column(
                                        children: [
                                          Text(
                                            managePodcastListController
                                                .podcastList[index].title!,
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
                                                          managePodcastListController
                                                              .podcastList[
                                                                  index]
                                                              .id!);
                                                      managePodcastListController
                                                          .deletePodcast(
                                                              managePodcastListController
                                                                  .podcastList[
                                                                      index]
                                                                  .id!);
                                                      managePodcastListController
                                                          .getDataManagePodcasts();
homeScreenController.getHomeData();

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
                                                      managePodcastListController
                                                              .podcastInfoEditList
                                                              .value =
                                                          managePodcastListController
                                                                  .podcastList[
                                                              index];
                                                      Get.toNamed(RouteScreens
                                                          .routeManagePodcastInfoEditScreen);
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
                                                " بازدید ${managePodcastListController.podcastList[index].view!}",
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
                                          //   managePodcastListController
                                          //       .podcastList[index].catName!,
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

                  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.images.sadtech.toString(),
                            height: Sizes.size.height / 5,
                            width: Sizes.size.width / 2,
                          ),
                          SizedBox(
                            height: Sizes.size.height / 24,
                          ),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: MyStr.managePodcastEmptyStateText,
                                  style: TextStyle(
                                      fontFamily: "dana",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: themeController.isDarkMode.value ==
                                              false
                                          ? Colors.black
                                          : Colors.white))),
                        ],
                      ),
                    ),
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
            managePodcastListController.clearVariables();

            Get.toNamed(RouteScreens.routeManagePodcastInfoScreen);
          },
          child: const Text(
            'بریم یه پادکست  اضافه کنیم',
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
