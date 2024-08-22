// ignore_for_file: file_names

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/animatedIconCont.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Components/themes/decoration.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_Info_C.dart';
import 'package:techblog_project/Controller/article_controller/articleInfo_C.dart';
import 'package:techblog_project/Controller/article_controller/articleList_S_C.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Controller/theme.controller.dart';

class ArticleInfoScreen extends StatelessWidget {
  ArticleInfoScreen({super.key});

  final articleInfoController = Get.find<ArticleInfoController>();
  final articleListController = Get.find<ArticleListController>();
  final podcastItemController = Get.find<PodcastItemController>();
    final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    debugPrint(articleInfoController.isFavoriteUI.toString());

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children:[ SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: 
              Obx(() => articleInfoController.loading.isFalse
                  ? Column(
                      children: [
                        Stack(
                          children: [
                            // !Poster
                            infosPosterImage(
                                controller: articleInfoController
                                    .articleInfoList.value.image!),
                            // ! ArticleInfoScreenAppBar
                            mainAppbarsWithBookmark(
                              bookmmark: bookmark(),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 5,
                              left: 5,
                              child: Text(
                                articleInfoController
                                    .articleInfoList.value.title!,
                                style: Sizes.theme.headlineMedium,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Sizes.widthsize, right: Sizes.widthsize),
                          child: Column(
                            children: [
                              SizedBox(
                                height: Sizes.widthsize,
                              ),
                              // !Name & Profile
                              Padding(
                                padding: EdgeInsets.only(left: Sizes.widthsize),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                       AvatarGlow(
                      animate: true,
                      glowRadiusFactor: 0.4,
                      glowColor: themeController.isDarkMode.value == false
                          ? MySolidColors.mainColor
                          : Colors.white,
                      child: profileMainIcon(),
                    ),
                                        SizedBox(
                                          width: Sizes.widthsize,
                                        ),
                                        Text(
                                          articleInfoController
                                              .articleInfoList.value.author!,
                                          style:  TextStyle(
          fontFamily: "dana",
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color:
          themeController.isDarkMode.value == false
                                ? Colors.black
                                : Colors.white),
          
           
                                        ),
                                        SizedBox(
                                          width: Sizes.widthsize,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      articleInfoController
                                          .articleInfoList.value.createdAt!,
                                      style: Sizes.theme.labelLarge,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Sizes.size.height / 28,
                              ),
                              // ! content
          
                              articleContentSection(
                                  controller: articleInfoController
                                      .articleInfoList.value.content!),
                              const SizedBox(
                                height: 16,
                              ),
                              // ! Tags
                              tags(),
                              SizedBox(
                                height: Sizes.widthsize,
                              ),
                              //  !related
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  MyStr.relatedText,
                                  style: Sizes.theme.displayLarge,
                                ),
                              ),
                              SizedBox(
                                height: Sizes.widthsize,
                              ),
                              relatedContainer(
                                articleInfoController: articleInfoController,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  // !while data not get
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300,
                        ),
                        SpinKitCircle(
                          size: 100,
                          color: MySolidColors.mainColor,
                        ),
                      ],
                    )),
              
            
          ),
          
          floatingPlayerButton(podcastItemController: podcastItemController)
          ]
        ),
      ),
    );
  }

// !bookmark
  GestureDetector bookmark() {
    return GestureDetector(
      onTap: () async {
        articleInfoController.isFavoriteUI.value
            ? 
             Get.snackbar(MyStr.infoArticleScreenBookMarkSnackbar,
          MyStr.infoArticleScreenBookMarkCantSnackbarText,
          animationDuration: const Duration(seconds: 1),
          forwardAnimationCurve: Curves.linearToEaseOut,
          backgroundColor: MySolidColors.mainColor,
          colorText: MySolidColors.scaffoldBack)
            
          
            : await articleInfoController.storeFavoriteArticle();
        articleInfoController.isFavoriteUI.value = true;
      },
      child: articleInfoController.isFavoriteUI.value
          ? const Icon(
              shadows: [Shadow(blurRadius: 5, color: MySolidColors.mainColor)],
              Icons.bookmark_added_rounded,
              color: MySolidColors.scaffoldBack,
            )
          : const Icon(
              shadows: [Shadow(blurRadius: 5, color: MySolidColors.mainColor)],
              Icons.bookmark_add_outlined,
              color: MySolidColors.scaffoldBack,
            ),
    );
  }

// !RelatedContainer
  Widget relatedContainer({
    required ArticleInfoController articleInfoController,
  }) {
    return SizedBox(
      height: Sizes.size.height / 4,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              articleInfoController.getArticleInfo(
                  articleInfoController.articleRelatedList[index].id!);
            },
            child: Padding(
              padding: EdgeInsets.only(right: index == 0 ? 0 : Sizes.widthsize),
              child: SizedBox(
                height: Sizes.size.height / 16,
                width: Sizes.size.width / 2.8,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Stack(children: [
                      CachedNetworkImage(
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.image_not_supported_rounded,
                              size: 50);
                        },
                        placeholder: (context, url) {
                          return loadingSpinKit();
                        },
                        imageUrl: articleInfoController
                            .articleRelatedList[index].image!,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: Sizes.size.height / 5.7,
                            width: Sizes.size.width / 2.8,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: Color.fromARGB(210, 0, 25, 50),
                                  )
                                ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                image: DecorationImage(
                                    fit: BoxFit.cover, image: imageProvider)),
                            foregroundDecoration: LightThemeDecorations.apFront,
                          );
                        },
                      ),
                      Positioned(
                          bottom: 10,
                          left: 5,
                          right: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                articleInfoController
                                    .articleRelatedList[index].author!,
                                style: Sizes.theme.displaySmall,
                              ),
                              Text(
                                "view ${articleInfoController.articleRelatedList[index].view}",
                                style: Sizes.theme.displaySmall,
                              )
                            ],
                          ))
                    ]),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      articleInfoController.articleRelatedList[index].title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      style:  TextStyle(
                            fontFamily: "dana",
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: themeController.isDarkMode.value == false
                                ? Colors.black
                                : Colors.white),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

// !Tags
  SizedBox tags() {
    return SizedBox(
      height: Sizes.size.height / 10,
      child: ListView.builder(
        itemCount: articleInfoController.articleInfoTagsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              await articleListController.getArticleListWithTagsId(
                  articleInfoController.articleInfoTagsList[index].id!);
              Get.find<ArticleListController>().appBarText.value =
                  articleInfoController.articleInfoTagsList[index].title!;
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                width: Sizes.size.width / 4,
                decoration: LightThemeDecorations.articleInfoScreenTags,
                child: Text(
                  textAlign: TextAlign.center,
                  articleInfoController.articleInfoTagsList[index].title!,
                  style: Sizes.theme.headlineMedium,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
