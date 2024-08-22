// ignore_for_file: file_names, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_Info_C.dart';
import 'package:techblog_project/Controller/article_controller/articleInfo_C.dart';
import 'package:techblog_project/Controller/article_controller/articleList_S_C.dart';
import 'package:techblog_project/Components/comp.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key});

  final articleInfoController = Get.find<ArticleInfoController>();
  final articleListController = Get.find<ArticleListController>();
  final podcastItemController = Get.find<PodcastItemController>();
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0)).then((value) {
      articleListController.getArticleHighListData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: listsAppbar(appbarText: articleListController.appBarText.value),
        body: Stack(children: [

          // !stack child two data
          Obx(
            () => Padding(
              padding: EdgeInsets.only(right: Sizes.widthsize, top: 0),
              child: RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  displacement: 5,
                  edgeOffset: 0,
                  strokeWidth: 3,
                  backgroundColor: MySolidColors.mainColor,
                  color: Colors.white,
                  onRefresh: _refresh,
                  child:
//                 articleListController.toggleState.value ==0
// ?
                      highView()
                  // :
                  // lowView()
                  ),
            ),
          ),
          floatingPlayerButton(podcastItemController: podcastItemController)
        ]),
      ),
    );
  }

  ListView highView() {
    return ListView.builder(
      itemCount: articleListController.articleList.length,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            articleInfoController.getArticleInfo(
                articleListController.articleList[index].id.toString());
            debugPrint(articleListController.articleList[index].isFavorite!
                .toString());
            articleInfoController.isFavoriteUI.value =
                articleListController.articleList[index].isFavorite!;
          },
          child: Padding(
            padding: EdgeInsets.only(top: Sizes.widthsize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // !ArticleImage
                listsImage(
                    index: index,
                    controller: articleListController.articleList[index].image
                        .toString()),

              
                const SizedBox(
                  width: 10,
                ),
                // !Title & View & Publisher
                secondSection(index)
              ],
            ),
          ),
        );
      },
    );
  }

  // !Title & View & Publisher
  SizedBox secondSection(int index) {
    return SizedBox(
      width: Sizes.size.width / 1.7,
      child: Column(
        children: [
          Text(
            articleListController.articleList[index].title!,
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
          Text(articleListController.articleList[index].isFavorite.isNull
              ? 'null'
              : "${articleListController.articleList[index].isFavorite!}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                articleListController.articleList[index].author == null
                    ? 'نامعلوم'
                    : articleListController.articleList[index].author!,
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
                " بازدید ${articleListController.articleList[index].view!}",
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

  
}
