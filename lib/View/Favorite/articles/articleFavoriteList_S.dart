// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Components/themes/decoration.dart';
import 'package:techblog_project/Controller/Favorite/articles/ArticleFavoriteList_C.dart';
import 'package:techblog_project/Controller/Favorite/articles/ArticleFavorite_Info_C.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_Info_C.dart';

class ArticleFavoriteListScreen extends StatelessWidget {
  ArticleFavoriteListScreen({super.key});
  final articleFavoriteListController =
    Get.put(ArticleFavoriteListController());

      // Get.find<ArticleFavoriteListController>();
  final articleInfoController =
      Get.put(ArticleFavoriteInfoController());

  //  Get.find<ArticleFavoriteInfoController>();
  final podcastItemController = 
      Get.put(PodcastItemController());

  // Get.find<PodcastItemController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: articleFavoriteListAppbar(),
        body: Stack(children: [
          Obx(
            () => Padding(
              padding: EdgeInsets.only(right: Sizes.widthsize),
              child: ListView.builder(
                itemCount:
                    articleFavoriteListController.articleFavoriteList.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // !Route to Info
                      articleInfoController.getArticleInfo(
                          articleFavoriteListController
                              .articleFavoriteList[index].article_id
                              .toString());
                      articleInfoController.favID.value =
                          articleFavoriteListController
                              .articleFavoriteList[index].fav_id!;
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: Sizes.widthsize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // !Image
                          listsImage(
                              index: index,
                              controller: articleFavoriteListController
                                  .articleFavoriteList[index].image!),
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
              ),
            ),
          ),
          floatingPlayerButton(podcastItemController: podcastItemController)
        ]),
      ),
    );
  }

  // !Title & View & Publisher
  SizedBox secondSection(int index) {
    return SizedBox(
      width: Sizes.size.width / 1.7,
      child: Column(
        children: [
          Text(
            articleFavoriteListController.articleFavoriteList[index].title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Sizes.theme.titleLarge,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          SizedBox(
            height: Sizes.size.height / 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                articleFavoriteListController
                            .articleFavoriteList[index].author ==
                        null
                    ? 'نامعلوم'
                    : articleFavoriteListController
                        .articleFavoriteList[index].author!,
                style: Sizes.theme.bodyLarge,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                " بازدید ${articleFavoriteListController.articleFavoriteList[index].view!}",
                style: Sizes.theme.labelSmall,
              ),
            ],
          )
        ],
      ),
    );
  }

  // !articleFavoriteListAppbar
  PreferredSize articleFavoriteListAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const SizedBox(
            width: 15,
          ),
          Container(
            width: 50,
            height: 50,
            decoration: LightThemeDecorations.listsAppbar,
            child: InkWell(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back,
                color: MySolidColors.scaffoldBack,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                MyStr.articleFavoriteAppbarText,
                style: TextStyle(
                    fontFamily: "dana",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: themeController.isDarkMode.value == false
                        ? MySolidColors.mainColor
                        : Colors.white)
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          )
        ],
      ),
    );
  }
}
