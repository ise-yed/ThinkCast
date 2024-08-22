// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:techblog_project/Components/animatedIconCont.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Controller/Favorite/Podcasts/podcasts_Favorite_Info_C.dart';
import 'package:techblog_project/Controller/Favorite/Podcasts/podcasts_Favorite_List_C.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/Model/podcastsModels/podcast_Model.dart';

class PodcastFavoriteInfoScreen extends StatelessWidget {
  PodcastFavoriteInfoScreen({super.key});
  final PodcastModel podcastmodel = Get.arguments;
  final podcastFavoriteInfoController =
      Get.find<PodcastFavoriteInfoController>();
        final podcastFavoriteListController =
      Get.find<PodcastFavoriteListController>();
        final ThemeController themeController = Get.find();


  @override
  Widget build(BuildContext context) {
    podcastFavoriteInfoController.getPodcastsInfo(id: podcastmodel.podcast_id!);

    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      // !Poster
                      infosPosterImage(controller: podcastmodel.poster!),
                      // ! ArticleInfoScreenAppBar
                      articleInfoScreenAppBar(size: Sizes.size),
                      Positioned(
                        bottom: 20,
                        right: 5,
                        left: 5,
                        child: Text(
                          podcastmodel.title!,
                          style: Sizes.theme.headlineMedium,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: Sizes.size.width / 11),
                        child: Row(
                          children: [
                            AvatarGlow(
                      animate: true,
                      glowRadiusFactor: 0.4,
                      glowColor: themeController.isDarkMode.value == false
                          ? MySolidColors.mainColor
                          : Colors.white,
                      child: profileMainIcon(),
                    ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              podcastmodel.author!,
                              style: Sizes.theme.titleLarge,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // !Show File Section
                      podcastFileSection(
                          podcastItemController: podcastFavoriteInfoController)
                    ],
                  )
                ],
              ),
            ),
          ),
          // !player
          player(podcastItemController: podcastFavoriteInfoController),
        ]),
      ),
    );
  }

// !ArticleInfoScreenAppBar
  Widget articleInfoScreenAppBar({required Size size}) {
    return SizedBox(
      width: size.width,
      height: Sizes.size.height / 8,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
    podcastFavoriteListController.getFavoritePodcastsList();


                  Get.back();
                } ,
                child: const Icon(
                  shadows: [
                    Shadow(blurRadius: 5, color: MySolidColors.mainColor)
                  ],
                  Icons.arrow_back,
                  color: MySolidColors.scaffoldBack,
                ),
              ),
              Row(
                children: [
                  // !bookmark
                  GestureDetector(
                    onTap: () async {
                      podcastFavoriteInfoController.isFavorite.value
                          ? await podcastFavoriteInfoController
                              .deleteFavotireArticle()
                          : Get.snackbar(
                              MyStr.infoArticleScreenBookMarkSnackbar,
                              MyStr.infoArticleScreenCantBookMarkSnackbar);

                      // articleInfoController.bookMark();
                    },
                    child: podcastFavoriteInfoController.isFavorite.value
                        ? const Icon(
                            shadows: [
                              Shadow(
                                  blurRadius: 5, color: MySolidColors.mainColor)
                            ],
                            Icons.bookmark_added_rounded,
                            color: MySolidColors.scaffoldBack,
                          )
                        : const Icon(
                            shadows: [
                              Shadow(
                                  blurRadius: 5, color: MySolidColors.mainColor)
                            ],
                            Icons.bookmark_add_outlined,
                            color: MySolidColors.scaffoldBack,
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // !Share
                  GestureDetector(
                    onTap: () => Share.share(MyStr.shareDrawerText),
                    child: const Icon(
                      shadows: [
                        Shadow(blurRadius: 5, color: MySolidColors.mainColor)
                      ],
                      Icons.share,
                      color: MySolidColors.scaffoldBack,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
