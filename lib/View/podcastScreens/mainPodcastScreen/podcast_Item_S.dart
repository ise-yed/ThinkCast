// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/animatedIconCont.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_Info_C.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/Model/podcastsModels/podcast_Model.dart';
import 'package:avatar_glow/avatar_glow.dart';

class PodcastItemScreen extends StatelessWidget {
  final PodcastModel podcastmodel = Get.arguments;
  final podcastItemController = Get.find<PodcastItemController>();
  final ThemeController themeController = Get.find();

  PodcastItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    podcastItemController.getPodcastsInfo(id: podcastmodel.id!);
    debugPrint(podcastItemController.isFavorite.value.toString());
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [

          Column(
            children: [
              SizedBox(
                height: Sizes.size.height / 3.2,
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.only(right: Sizes.size.width / 11),
                child: Row(
                  children: [
                    AvatarGlow(
                      startDelay: const Duration(seconds: 1),
                      animate: true,
                      glowRadiusFactor: 10,
                      glowColor: themeController.isDarkMode.value == false
                          ? MySolidColors.mainColor
                          : Colors.white,
                      child: profileMainIcon(),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    podcastmodel.author != null
                        ? Text(
                            podcastmodel.author!,
                            style: TextStyle(
                                fontFamily: "dana",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: themeController.isDarkMode.value == false
                                    ? Colors.black
                                    : Colors.white),
                          )
                        : Text(
                            'نامشخص',
                            style: Sizes.theme.titleLarge,
                          )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // !Show File Section
              podcastFileSection(podcastItemController: podcastItemController)
            ],
          ),
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            child: Stack(
              children: [
                // !Poster
                infosPosterImage(controller: podcastmodel.poster!),
                // ! MainAppbarsWithBookmark
                mainAppbarsWithBookmark(
                  bookmmark: podcastBookmark(),
                ),
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
          ),
                    // !podcastButtomNavigation

          player(podcastItemController: podcastItemController),
        ]),
      ),
    );
  }

// ! bookmark
  GestureDetector podcastBookmark() {
    return GestureDetector(
      onTap: () async {
        podcastItemController.isFavorite.value
            ? Get.snackbar(MyStr.infoArticleScreenBookMarkSnackbar,
                MyStr.infoArticleScreenBookMarkCantSnackbarText)
            : await podcastItemController.storeFavoritePodcasts();
        podcastItemController.isFavorite.value = true;
      },
      child: podcastItemController.isFavorite.value
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
}
