// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: avoid_print, unrelated_type_equality_checks, deprecated_member_use, must_be_immutable, file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_Info_C.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_List_C.dart';
import 'package:techblog_project/Controller/article_controller/articleInfo_C.dart';
import 'package:techblog_project/Controller/article_controller/articleList_S_C.dart';
import 'package:techblog_project/Controller/homeScreenController/searchScreen_C.dart';
import 'package:techblog_project/gen/assets.gen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  Rx<TextEditingController> searchDataTextController =
      TextEditingController().obs;
  final searchScreenController = Get.find<SearchScreenController>();
  final podcastItemController = Get.find<PodcastItemController>();
  final podcastListController = Get.find<PodcastListController>();
  final articleInfoController = Get.find<ArticleInfoController>();
  final articleListController = Get.find<ArticleListController>();

  Future<void> _refresh() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          // for hideen default icon
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          title: searchappbar()),
      body: Obx(
        () => Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                color: searchScreenController
                                            .toggleState.value ==
                                        0
                                    ? MySolidColors.mainColor
                                    : MySolidColors.mainColor.withOpacity(0.1)),
                            child: TextButton(
                                onPressed: () {
                                  searchScreenController.toggleState.value = 0;
                                  print('podcast');
                                  //     index == 0 ? print('podcast') : print('article');
                                },
                                child: Text(
                                  'پادکست',
                                  style: TextStyle(
                                      fontFamily: "dana",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: searchScreenController
                                                  .toggleState.value ==
                                              0
                                          ? Colors.white
                                          : Colors.white),
                                )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                color: searchScreenController
                                            .toggleState.value ==
                                        1
                                    ? MySolidColors.mainColor
                                    : MySolidColors.mainColor.withOpacity(0.1)),
                            child: TextButton(
                              onPressed: () {
                                print('article');
                                searchScreenController.toggleState.value = 1;
                              },
                              child: Text('مقاله',
                                  style: TextStyle(
                                      fontFamily: "dana",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: searchScreenController
                                                  .toggleState.value ==
                                              1
                                          ? Colors.white
                                          : Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
               
                ),
                const SizedBox(
                  height: 16,
                ),
                RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  displacement: 5,
                  edgeOffset: 0,
                  strokeWidth: 3,
                  backgroundColor: MySolidColors.mainColor,
                  color: Colors.white,
                  onRefresh: _refresh,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: searchScreenController.toggleState.value == 1
                        ? listViewScreens(
                            controller: searchScreenController,
                            dataList:
                                searchScreenController.toggleState.value == 1
                                    ? searchScreenController.resultArticles
                                    : searchScreenController.resultPodcasts,
                            state: searchScreenController.toggleState.value)
                        : listViewScreenss(
                            controller: searchScreenController,
                            dataList:
                                searchScreenController.toggleState.value == 1
                                    ? searchScreenController.resultArticles
                                    : searchScreenController.resultPodcasts,
                            state: searchScreenController.toggleState.value),
                  ),
                )
              ],
            ),
          ),
          floatingPlayerButton(podcastItemController: podcastItemController)
        ]),
      ),
    ));
  }

  Widget listViewScreens(
      {required dynamic controller,
      required dynamic dataList,
      required dynamic state}) {
    return SizedBox(
      height: Get.size.height,
      child: ListView.builder(
        itemCount: dataList.length,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              articleInfoController
                  .getArticleInfo(dataList[index].id.toString());
            },
            child: Padding(
              padding: EdgeInsets.only(top: Sizes.widthsize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // !ArticleImage
                  listsImage(
                      index: index,
                      controller: dataList[index].image.toString()),
                  const SizedBox(
                    width: 10,
                  ),
                  // !Title & View & Publisher
                  secondSection(index: index, datalist: dataList)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget listViewScreenss(
      {required dynamic controller,
      required dynamic dataList,
      required dynamic state}) {
    return SizedBox(
      height: Get.size.height,
      child: ListView.builder(
        itemCount: dataList.length,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              podcastItemController.getPodcastsInfo(
                  id: dataList[index].id.toString());
              Get.toNamed(RouteScreens.routePodcastItemScreen,
                  arguments: dataList[index]);
            },
            child: Padding(
              padding: EdgeInsets.only(top: Sizes.widthsize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // !ArticleImage
                  listsImage(
                      index: index,
                      controller: dataList[index].poster.toString()),
                  const SizedBox(
                    width: 10,
                  ),
                  // !Title & View & Publisher
                  secondSection(index: index, datalist: dataList)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // !Title & View & Publisher
  SizedBox secondSection({required int index, required dynamic datalist}) {
    return SizedBox(
      width: Sizes.size.width / 1.7,
      child: Column(
        children: [
          Text(
            datalist[index].title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontFamily: "dana",
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: themeController.isDarkMode.value == false
                    ? Colors.black
                    : Colors.white),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          SizedBox(
            height: Sizes.size.height / 28,
          ),
          Text("${datalist[index].isFavorite!}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                datalist[index].author == null
                    ? 'نامعلوم'
                    : datalist[index].author!,
                style: TextStyle(
                    fontFamily: "dana",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: themeController.isDarkMode.value == false
                        ? Colors.black
                        : Colors.white),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                " بازدید ${datalist[index].view!}",
                style: TextStyle(
                    fontFamily: "dana",
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: themeController.isDarkMode.value == false
                        ? Colors.black
                        : Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  // !searchappbar
  Widget searchappbar() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: SvgPicture.asset(
              color: themeController.isDarkMode != false
                  ? Colors.white
                  : MySolidColors.mainColor,
              Assets.images.logo.toString(),
              width: Sizes.size.width / 3,
              height: Sizes.size.height / 5.5,
            ),
          ),
          Obx(
            () {
              return Expanded(
                child: SizedBox(
                  // color: Colors.black,
                  height: 30,
                  child: TextField(
                    onChanged: (value) {
                      searchScreenTextFieldFunc(value);
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    cursorColor: MySolidColors.mainColor,
                    textAlign: TextAlign.center,
                    controller: searchDataTextController.value,
                    decoration: const InputDecoration(
                        fillColor: Color.fromARGB(220, 255, 255, 255),
                        hintStyle: TextStyle(
                            locale: Locale('fa'),
                            fontSize: 10,
                            color: Colors.black),
                        hintText: 'دنبال چی میگردی؟',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            borderSide: BorderSide(
                                color: MySolidColors.mainColor,
                                width: 3,
                                strokeAlign: 5,
                                style: BorderStyle.solid))),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  searchScreenTextFieldFunc(String value) {
    searchScreenController.resultArticles.clear();
    searchScreenController.resultPodcasts.clear();
    if (searchScreenController.toggleState.value == 1) {
      for (var element in articleListController.articleList) {
        if (element.title!.contains(value)) {
          searchScreenController.resultArticles.add(element);
        }
      }
    } else {
      for (var element in podcastListController.podcastList) {
        if (element.title!.contains(value)) {
          searchScreenController.resultPodcasts.add(element);
        }
      }
    }
  }
}
