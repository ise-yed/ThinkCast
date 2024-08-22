// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_List_C.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_Info_C.dart';

class PodcastListScreen extends StatelessWidget {
  PodcastListScreen({super.key});
  final podcastListController = Get.find<PodcastListController>();
  final PodcastItemController podcastItemController =
      Get.put(PodcastItemController());
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0))
        .then((value) => podcastListController.getPodcastsList());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: listsAppbar(appbarText: MyStr.mainPodcastListAppbarText),
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          displacement: 5,
          edgeOffset: 0,
          strokeWidth: 3,
          backgroundColor: MySolidColors.mainColor,
          color: Colors.white,
          onRefresh: _refresh,
          child: Stack(children: [
            Obx(
              () => Padding(
                padding: EdgeInsets.only(right: Sizes.widthsize),
                child: ListView.builder(
                  itemCount: podcastListController.podcastList.length,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(RouteScreens.routePodcastItemScreen,
                            arguments:
                                podcastListController.podcastList[index]);
                        podcastItemController.podcast_id.value =
                            podcastListController.podcastList[index].id!;

                        podcastItemController.isFavorite.value =
                            podcastListController
                                .podcastList[index].isFavorite!;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: Sizes.widthsize),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // !ArticleImage
                            listsImage(
                                index: index,
                                controller: podcastListController
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
            alignment: Alignment.center,
            child: Text(podcastListController.podcastList[index].title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: "dana",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: themeController.isDarkMode.value == false
                        ? Colors.black
                        : Colors.white)),
          ),
          SizedBox(
            height: Sizes.size.height / 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                podcastListController.podcastList[index].publisher == null
                    ? 'نامعلوم'
                    : podcastListController.podcastList[index].publisher!,
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
                " بازدید ${podcastListController.podcastList[index].view!}",
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
