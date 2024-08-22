import 'dart:io';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Components/themes/decoration.dart';
import 'package:techblog_project/Components/themes/theme_text_style.dart';
import 'package:techblog_project/Controller/filePicker_C.dart';
import 'package:techblog_project/Controller/homeScreenController/homeScreen_C.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/Services/filePicker_services.dart';
import 'package:techblog_project/gen/assets.gen.dart';

final filepickerController = Get.find<FilePickerController>();
final ThemeController themeController = Get.find();

// !TagsItem
// ignore: non_constant_identifier_names
Widget TagsItem(index, widthsize, theme) {
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 0, index == 0 ? widthsize : 0, 0),
    child: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(
              colors: MyGradientColors.tags,
              begin: Alignment.topRight,
              end: Alignment.topLeft)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: Assets.icons.hashtag.provider(),
              height: 20,
              color: MySolidColors.hashtagIconColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              Get.find<HomeScreenController>().tagsList[index].title!,
              style: Sizes.theme.headlineMedium,
            ),
          ],
        ),
      ),
    ),
  );
}

// ! divider
class Dividers extends StatelessWidget {
  const Dividers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: MySolidColors.dividers,
      thickness: 1.5,
      indent: 50,
      endIndent: 50,
    );
  }
}

class DDivider extends StatelessWidget {
  const DDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: MySolidColors.dividers,
      thickness: 1.5,
    );
  }
}

// ! Loading
Widget loadingSpinKit() {
  return const SpinKitThreeBounce(
    size: 15,
    color: Color.fromARGB(200, 0, 59, 100),
  );
}

// ! Appbars
// !managePodcastInfoScreenAppBar
Widget managepodcastInfoScreenAppBar(
    {required dynamic managePodcastController,
    required dynamic podcastItemController}) {
  return SizedBox(
    width: Sizes.size.width,
    height: Sizes.size.height / 8,
    child: Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                await managePodcastController.getDataManagePodcasts();
                Get.back();
                managePodcastController.clearVariables();
              },
              child: const Icon(
                shadows: [
                  Shadow(blurRadius: 5, color: MySolidColors.mainColor)
                ],
                Icons.arrow_back,
                color: MySolidColors.scaffoldBack,
              ),
            ),
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
        ),
      ),
    ),
  );
}

// !manageArticleInfoScreenAppBar
Widget manageArticleInfoScreenAppBar(
    {required dynamic manageArticleController}) {
  return SizedBox(
    width: Sizes.size.width,
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
                manageArticleController.clearVariables();
                debugPrint('cleard');
                Get.back();
              },
              child: const Icon(
                shadows: [
                  Shadow(blurRadius: 5, color: MySolidColors.mainColor)
                ],
                Icons.arrow_back,
                color: MySolidColors.scaffoldBack,
              ),
            ),
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
        ),
      ),
    ),
  );
}

// ! MainAppbarsWithBookmark
Widget mainAppbarsWithBookmark({required Widget bookmmark}) {
  return SizedBox(
    width: Sizes.size.width,
    height: Sizes.size.height / 8,
    child: Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Get.back(),
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
                bookmmark,
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

// !ListsAppbar
PreferredSize listsAppbar({required String appbarText}) {
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
            child: Text(appbarText,
                style: TextStyle(
                    fontFamily: "dana",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: themeController.isDarkMode.value == false
                        ? MySolidColors.mainColor
                        : Colors.white)),
          ),
        ),
        const SizedBox(
          width: 30,
        )
      ],
    ),
  );
}

// ! ListsImage
Widget listsImage({required int index, required dynamic controller}) {
  return CachedNetworkImage(
    errorWidget: (context, url, error) {
      return Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Color.fromARGB(210, 0, 25, 50),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: SvgPicture.asset(
              Assets.images.logo.toString(),
              height: Sizes.size.height / 7.5,
              width: Sizes.size.width / 3.5,
            ),
          ),
        ],
      );
    },
    imageUrl: controller,
    // controller.articleList[index].image.toString(),
    fit: BoxFit.cover,
    placeholder: (context, url) {
      return loadingSpinKit();
    },
    imageBuilder: (context, imageProvider) {
      return Container(
        height: Sizes.size.height / 7.5,
        width: Sizes.size.width / 3.5,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            image: DecorationImage(fit: BoxFit.cover, image: imageProvider)),
      );
    },
  );
}

// !InfosPosterImage
Widget infosPosterImage({required dynamic controller}) {
  return CachedNetworkImage(
    fit: BoxFit.cover,
    errorWidget: (context, url, error) {
      return Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
        child: Container(
          foregroundDecoration: LightThemeDecorations.homeScreenPosterFront,
          height: Sizes.size.height / 3.2,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(blurRadius: 10, color: MySolidColors.mainColor)
              ],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(Assets.images.whitelogos.path))),
        ),
      );
    },
    placeholder: (context, url) {
      return loadingSpinKit();
    },
    // todo:dadw
    imageUrl: controller,
    imageBuilder: (context, imageProvider) {
      return Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
        child: Container(
          foregroundDecoration: LightThemeDecorations.homeScreenPosterFront,
          height: Sizes.size.height / 3.2,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(blurRadius: 10, color: MySolidColors.mainColor)
              ],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              image: DecorationImage(fit: BoxFit.cover, image: imageProvider)),
        ),
      );
    },
  );
}

// !createPosterImage
Padding storePosterImage({required dynamic controller}) {
  return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
      child: controller.fileImageData.value.name == 'nothing'
          ? Container(
              foregroundDecoration: LightThemeDecorations.homeScreenPosterFront,
              height: Sizes.size.height / 3.2,
              width: Sizes.size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(blurRadius: 10, color: MySolidColors.mainColor)
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: const Center(
                child: Icon(Icons.image_not_supported_rounded, size: 50),
              ))
          : Container(
              foregroundDecoration: LightThemeDecorations.homeScreenPosterFront,
              height: Sizes.size.height / 3.2,
              width: Sizes.size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(blurRadius: 10, color: MySolidColors.mainColor)
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  image: FileImage(
                    File(controller.fileImageData.value.path!),
                  ),
                ),
              ),
            ));
}

// !Player
Widget player({required podcastItemController}) {
  return Obx(
    () => Positioned(
        bottom: 10,
        left: 10,
        right: 10,
        child: Container(
          height: Sizes.size.height / 12,
          decoration: LightThemeDecorations.podcastItemScreenBottomNanigation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // !ProgressBar

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ! next Buttom

                  GestureDetector(
                    onTap: () async {
                      await podcastItemController.player.seekToNext();
                      podcastItemController.currentIndex.value =
                          podcastItemController.player.currentIndex!;
                      podcastItemController.timerCheck();
                    },
                    child: const Icon(
                      Icons.navigate_next_outlined,
                      color: MySolidColors.scaffoldBack,
                      size: 35,
                    ),
                  ),

                  // ! state Buttom

                  GestureDetector(
                    onTap: () async {
                      podcastItemController.player.playing
                          ? podcastItemController.timer!.cancel()
                          : podcastItemController.progressBar();

                      podcastItemController.player.playing
                          ? podcastItemController.player.pause()
                          : podcastItemController.player.play();
                      podcastItemController.progressBar();
                      podcastItemController.playState.value =
                          podcastItemController.player.playing;
                      podcastItemController.currentIndex.value =
                          podcastItemController.player.currentIndex!;
                    },
                    child: Icon(
                      podcastItemController.playState.value
                          ? Icons.pause_circle_filled_outlined
                          : Icons.play_circle_fill_outlined,
                      color: MySolidColors.scaffoldBack,
                      size: 45,
                    ),
                  ),

                  // ! previous Buttom

                  GestureDetector(
                    onTap: () async {
                      await podcastItemController.player.seekToPrevious();
                      podcastItemController.currentIndex.value =
                          podcastItemController.player.currentIndex!;
                      podcastItemController.timerCheck();
                    },
                    child: const Icon(
                      Icons.navigate_before_outlined,
                      color: MySolidColors.scaffoldBack,
                      size: 35,
                    ),
                  ),
// !LoopButtom
                  GestureDetector(
                    onTap: () {
                      podcastItemController.loopButtom();
                      podcastItemController.currentIndex.value =
                          podcastItemController.player.currentIndex!;
                    },
                    child: Icon(
                      Icons.repeat_rounded,
                      color: podcastItemController.isLoopAll.value
                          ? const Color.fromRGBO(0, 221, 249, 1)
                          : MySolidColors.scaffoldBack,
                      size: 30,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Sizes.size.width / 2,
                        child: ProgressBar(
                          timeLabelTextStyle: const TextStyle(
                              color: MySolidColors.scaffoldBack),
                          progress: podcastItemController.progress.value,
                          total: podcastItemController.player.duration ??
                              const Duration(seconds: 0),
                          buffered: podcastItemController.buffred.value,
                          bufferedBarColor: Colors.yellowAccent,
                          thumbColor: Colors.yellow,
                          baseBarColor: MySolidColors.scaffoldBack,
                          progressBarColor: Colors.orange,
                          onSeek: (position) {
                            podcastItemController.player.seek(position);
                            podcastItemController.progressBar();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        )),
  );
}

// !podcastFileSection
Widget podcastFileSection({required podcastItemController}) {
  return Obx(
    () => Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(blurRadius: 5, color: MySolidColors.mainColor)
              ],
              borderRadius: BorderRadius.circular(30),
              color: themeController.isDarkMode.value == false
                  ? Colors.white
                  : const Color.fromARGB(255, 1, 10, 24)),
          height: Sizes.size.height / 2.50,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: podcastItemController.podcastsList.length,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  await podcastItemController.player
                      .seek(Duration.zero, index: index);
                  podcastItemController.currentIndex.value =
                      podcastItemController.player.currentIndex!;
                  podcastItemController.timerCheck();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          ImageIcon(
                            Assets.icons.morepodcast.provider(),
                            color: MySolidColors.blueTitle,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: Sizes.size.width / 1.5,
                            child: Obx(
                              () => Text(
                                podcastItemController
                                    .podcastsList[index].title!,
                                maxLines: 2,
                                style: podcastItemController
                                            .currentIndex.value ==
                                        index
                                    ? Sizes.theme.displayLarge
                                    : TextStyle(
                                        fontFamily: "dana",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            themeController.isDarkMode.value ==
                                                    false
                                                ? Colors.black
                                                : Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        podcastItemController.podcastsList[index].length!,
                        style: Sizes.theme.titleLarge,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )),
  );
}

// !  AddPodcastFile
// ignore: non_constant_identifier_names
Widget AddPodcastFile(
    {required managePodcastController,
    required podcastItemController,
    required Widget addPodcastFileButton}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, 0, Sizes.widthsize, 0),
    child: InkWell(
      onTap: () {
        Get.bottomSheet(
            backgroundColor: Colors.transparent,
            Container(
              width: Sizes.size.width,
              height: Sizes.size.height / 2,
              decoration: LightThemeDecorations.registerButtonSheet,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 24, bottom: 24, left: 16, right: 16),
                child: Obx(
                  () => Column(
                    children: [
                      // !title and bot
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.images.happytech.toString(),
                            height: 45,
                            width: 45,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            MyStr.podcastSelectTileText,
                            style: AppTheme.lightTheme.textTheme.titleLarge,
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ! part 1
                          GestureDetector(
                            onTap: () {
                              debugPrint('im from seledt Podcast');
                              pickAudioFile();
                            },
                            child: Container(
                              color: Colors.transparent,
                              width: 160,
                              height: 200,
                              child: Obx(
                                () => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          Assets.images.addmusic.path),
                                      width: 70,
                                      height: 70,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      MyStr.podcastselectText,
                                      style: AppTheme
                                          .lightTheme.textTheme.bodyLarge,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    filepickerController
                                                .fileAudioData.value.size !=
                                            0
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    debugPrint('delete  file');
                                                    filepickerController
                                                            .fileAudioData
                                                            .value =
                                                        PlatformFile(
                                                            name: 'nothing',
                                                            size: 0);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )),
                                              const Icon(
                                                Icons.music_note_rounded,
                                                color: Colors.green,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          )
                                        : const Icon(
                                            Icons.music_off_outlined,
                                            color: Colors.red,
                                          ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // ! part 2
                          GestureDetector(
                            onTap: () {
                              debugPrint('im from number picker');
                            },
                            child: SizedBox(
                              width: 160,
                              height: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        child: NumberPicker(
                                          textStyle: const TextStyle(
                                              color: MySolidColors.black),
                                          minValue: 0,
                                          maxValue: 100,
                                          value: managePodcastController
                                              .numberpickerSecondValue.value,
                                          onChanged: (value) {
                                            debugPrint(value.toString());
                                            managePodcastController
                                                .numberpickerSecondValue
                                                .value = value;
                                          },
                                        ),
                                      ),
                                      const Text('ثانیه'),
                                    ],
                                  ),
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      ':',
                                      style: TextStyle(
                                          fontSize: 50,
                                          color: MySolidColors.black),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        child: NumberPicker(
                                          textStyle: const TextStyle(
                                              color: MySolidColors.black),
                                          minValue: 0,
                                          maxValue: 100,
                                          value: managePodcastController
                                              .numberpickerMinuteValue.value,
                                          onChanged: (value) {
                                            managePodcastController
                                                .numberpickerMinuteValue
                                                .value = value;
                                          },
                                        ),
                                      ),
                                      const Text('دقیقه')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // !addPodcastFileButton
                      addPodcastFileButton
                    ],
                  ),
                ),
              ),
            ));
      },
      child: Row(
        children: [
          const Icon(
            Icons.add_box_rounded,
            color: MySolidColors.blueTitle,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            MyStr.addpodcastfileText,
            style: Sizes.theme.displayLarge,
          ),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    ),
  );
}

// !EmptyState
Center emptyState() {
  return Center(
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
                text: MyStr.manageArticleEmptyStateText,
                style: TextStyle(
                    fontFamily: "dana",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: themeController.isDarkMode.value == false
                        ? Colors.black
                        : Colors.white))),
      ],
    ),
  );
}

// !articleContentSection
Widget articleContentSection({required dynamic controller}) {
  return Container(
    decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(blurRadius: 5, color: MySolidColors.mainColor)
        ],
        borderRadius: BorderRadius.circular(30),
        color: themeController.isDarkMode.value == false
            ? Colors.white
            : const Color.fromARGB(255, 1, 10, 24)),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: HtmlWidget(controller,
          onLoadingBuilder: (context, element, loadingProgress) {
        return loadingSpinKit();
      },
          textStyle: TextStyle(
              fontFamily: "dana",
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: themeController.isDarkMode.value == false
                  ? Colors.black
                  : Colors.white)),
      // Html(data:controller )
    ),
  );
}

Obx floatingPlayerButton({required dynamic podcastItemController}) {
  return Obx(
    () => AnimatedPositioned(
        curve: Curves.easeInOutCubicEmphasized,
        duration: const Duration(seconds: 1),
        bottom: Sizes.size.height / 6.6,
        left: podcastItemController.playState.value ? 16 : -30,
        child: podcastItemController.playState.value
            ? Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(blurRadius: 1.5, color: MySolidColors.mainColor)
                ], color: MySolidColors.mainColor, shape: BoxShape.circle),
                child: GestureDetector(
                  onTap: () async {
                    podcastItemController.player.playing
                        ? podcastItemController.timer!.cancel()
                        : podcastItemController.progressBar();

                    podcastItemController.player.playing
                        ? podcastItemController.player.pause()
                        : podcastItemController.player.play();
                    podcastItemController.progressBar();
                    podcastItemController.playState.value =
                        podcastItemController.player.playing;
                    podcastItemController.currentIndex.value =
                        podcastItemController.player.currentIndex!;
                  },
                  child: Icon(
                    podcastItemController.playState.value
                        ? Icons.pause_circle_filled_outlined
                        : Icons.play_circle_fill_outlined,
                    color: MySolidColors.scaffoldBack,
                    size: 50,
                  ),
                ),
              )
            : Obx(
                () => Container(
                  height: 55,
                  width: 55,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(blurRadius: 1.5, color: MySolidColors.mainColor)
                  ], color: MySolidColors.mainColor, shape: BoxShape.circle),
                  child: GestureDetector(
                    onTap: () async {
                      podcastItemController.player.playing
                          ? podcastItemController.timer!.cancel()
                          : podcastItemController.progressBar();

                      podcastItemController.player.playing
                          ? podcastItemController.player.pause()
                          : podcastItemController.player.play();
                      podcastItemController.progressBar();
                      podcastItemController.playState.value =
                          podcastItemController.player.playing;
                      podcastItemController.currentIndex.value =
                          podcastItemController.player.currentIndex!;
                      debugPrint('butttttttttttttttttttttttttttttttt');
                    },
                    child: Icon(
                      podcastItemController.playState.value
                          ? Icons.pause_circle_filled_outlined
                          : Icons.play_circle_fill_outlined,
                      color: MySolidColors.scaffoldBack,
                      size: 50,
                    ),
                  ),
                ),
              )),
  );
}

// !loader
Center loader() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 200),
        SvgPicture.asset(
          Assets.images.happytech.toString(),
          height: Sizes.size.height / 5,
          width: Sizes.size.width / 2,
        ),
        SizedBox(
          height: Sizes.size.height / 24,
        ),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: MyStr.waitText,
                style: TextStyle(
                    fontFamily: "dana",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: themeController.isDarkMode.value == false
                        ? Colors.black
                        : Colors.white))),
      ],
    ),
  );
}
