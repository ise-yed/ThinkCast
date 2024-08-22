// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Components/themes/decoration.dart';
import 'package:techblog_project/Controller/Favorite/Podcasts/podcasts_Favorite_Info_C.dart';
import 'package:techblog_project/Controller/Favorite/Podcasts/podcasts_Favorite_List_C.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_Info_C.dart';

class PodcastFavoriteListScreen extends StatelessWidget {
  PodcastFavoriteListScreen({super.key});
  final podcastFavoriteListController =
      Get.find<PodcastFavoriteListController>();
  final PodcastFavoriteInfoController podcastFavoriteInfoController =
      Get.put(PodcastFavoriteInfoController());
      final podcastItemController = Get.find<PodcastItemController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: podcastListAppbar(),
        body: Stack(
          children:[ Obx(
            () => Padding(
              padding: EdgeInsets.only(right: Sizes.widthsize),
              child: ListView.builder(
                itemCount: podcastFavoriteListController.podcastList.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      podcastItemController.playState.value = false;
                      podcastItemController.player.pause();
                      Get.toNamed(RouteScreens.podcastFavoriteInfoScreen,
                          arguments:
                              podcastFavoriteListController.podcastList[index]);
                      debugPrint(
                          ' im from PFLS     ${podcastFavoriteListController.podcastList[index].fav_id}');
                      podcastFavoriteInfoController.favID.value =
                          podcastFavoriteListController
                              .podcastList[index].fav_id!;
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: Sizes.widthsize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // !Image
                          listsImage(
                              index: index,
                              controller: podcastFavoriteListController
                                  .podcastList[index].poster
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
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              podcastFavoriteListController.podcastList[index].title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Sizes.theme.titleLarge,
            ),
          ),
          SizedBox(
            height: Sizes.size.height / 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                podcastFavoriteListController.podcastList[index].publisher ==
                        null
                    ? 'نامعلوم'
                    : podcastFavoriteListController
                        .podcastList[index].publisher!,
                style: Sizes.theme.bodyLarge,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                " بازدید ${podcastFavoriteListController.podcastList[index].view!}",
                style: Sizes.theme.labelSmall,
              ),
            ],
          )
        ],
      ),
    );
  }

// !podcastListAppbar
  PreferredSize podcastListAppbar() {
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
                podcastFavoriteListController.appbarText.value,
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
