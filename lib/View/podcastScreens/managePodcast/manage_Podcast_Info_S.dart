// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon_animated/icon_animated.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Components/themes/decoration.dart';
import 'package:techblog_project/Controller/Podcast_Controller/managePodcast_C.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_Info_C.dart';
import 'package:techblog_project/Controller/filePicker_C.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/Services/filePicker_services.dart';
import 'package:techblog_project/gen/assets.gen.dart';

class ManagePodcastInfoScreen extends StatelessWidget {
  ManagePodcastInfoScreen({super.key});

  final managePodcastController = Get.find<ManagePodcastController>();
  final podcastItemController = Get.find<PodcastItemController>();
  // todo:bad performance
  final filepickerController = Get.find<FilePickerController>();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Obx(
              () => Column(
                children: [
                  Stack(
                    children: [
                      storePosterImage(controller: filepickerController),
                      managepodcastInfoScreenAppBar(
                          managePodcastController: managePodcastController,
                          podcastItemController: podcastItemController),
                      filePickerButton(),
                    ],
                  ),
                  Obx(
                    () => Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        PodcastEditText(),
                        const SizedBox(
                          height: 16,
                        ),
                        // ! title
                        Obx(
                          () => Text(
                            managePodcastController
                                .titletextEditingController.value.text,
                            style: TextStyle(
                                fontFamily: "dana",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: themeController.isDarkMode.value == false
                                    ? Colors.black
                                    : Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        SizedBox(
                          height: Sizes.widthsize,
                        ),
                        // !  AddPodcastFile
                        AddPodcastFile(
                            managePodcastController: managePodcastController,
                            podcastItemController: podcastItemController,
                            addPodcastFileButton: SizedBox(
                              height: 50,
                              width: 400,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await managePodcastController
                                        .storePodcastFile();
                                    podcastItemController.getPodcastsInfo(
                                        id: managePodcastController.podcastId!);
                                    filepickerController.fileAudioData.value =
                                        PlatformFile(name: 'nothing', size: 0);
                                    Get.back();

                                    // Get.offAllNamed(RouteScreens.routeSplashScreen);
                                  },
                                  child: const Text(
                                    MyStr.verify,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'dana',
                                      fontWeight: FontWeight.w300,
                                      color: MySolidColors.scaffoldBack,
                                    ),
                                  )),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        // !podcastFile Section
                        podcastFileSection(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // ! player
            // player(podcastItemController: podcastItemController),
            finishButton()
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0)).then((value) =>
        podcastItemController.getPodcastsInfo(
            id: managePodcastController.podcastId!));
  }

// !FinishButton
  Positioned finishButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.only(
            left: Sizes.size.width / 15,
            right: Sizes.size.width / 15,
            bottom: 10,
            top: 20),
        child: SizedBox(
          height: Get.height / 14,
          width: Get.width / 2,
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)))),
            onPressed: () async {
              managePodcastController.getDataManagePodcasts();
              managePodcastController.clearVariables();
              // Get.toNamed(RouteScreens.routeManagePodcastListScreen);

              Get.offAllNamed(RouteScreens.routeSplashScreen);
            },
            child: const Text(
              MyStr.finishedButtonText,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'dana',
                fontWeight: FontWeight.w300,
                color: MySolidColors.scaffoldBack,
              ),
            ),
          ),
        ),
      ),
    );
  }

// ! podcastFile Section
  Padding podcastFileSection() {
    return Padding(
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
          height: Sizes.size.height / 3,
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            displacement: 5,
            edgeOffset: 0,
            strokeWidth: 3,
            backgroundColor: MySolidColors.mainColor,
            color: Colors.white,
            onRefresh: _refresh,
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
                                          color: themeController
                                                      .isDarkMode.value ==
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
          ),
        ));
  }

// ! filePickerButton
  Positioned filePickerButton() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            width: Sizes.size.width / 3,
            height: Sizes.size.height / 22,
            decoration:
                LightThemeDecorations.manageArticleInfoScreenfilePickerButton,
            child: GestureDetector(
              onTap: () async {
                await pickImagefile();
                filepickerController.fileImageData.value.name != 'nothing'
                    ? verifydialogImage()
                    : null;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    MyStr.selectImage,
                    style: Sizes.theme.headlineMedium,
                  ),
                  const IconAnimated(
                    color: Colors.white,
                    active: true,
                    size: 40,
                    iconType: IconType.add,
                  ),

                  // const Icon(
                  //   Icons.add,
                  //   color: MySolidColors.scaffoldBack,
                  //   size: 25,
                  // )
                ],
              ),
            ),
          ),
        ));
  }

  // !  PodcastEditText
  // ignore: non_constant_identifier_names
  Padding PodcastEditText() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, Sizes.widthsize, 0),
      child: GestureDetector(
        onTap: () {
          titleUpdate();
          debugPrint(
              managePodcastController.titletextEditingController.value.text);
        },
        child: Row(
          children: [
            Image(
              image: Assets.icons.moretext.provider(),
              height: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              MyStr.podcastEditText,
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

  // !titleUpdate
  titleUpdate() {
    Get.defaultDialog(
        backgroundColor: MySolidColors.mainColor,
        title: MyStr.titlePodcastEditText,
        titleStyle: Sizes.theme.displayMedium,
        content: Container(
          decoration: LightThemeDecorations.manageArticleInfoScreentitleUpdate,
          child: TextField(
            controller:
                managePodcastController.titletextEditingController.value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              hintText: MyStr.writeArticleEditText,
            ),
            style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.text,
          ),
        ),
        radius: 15,
        confirm: ElevatedButton(
            onPressed: () {
              managePodcastController.storetitle();
              Get.back();
            },
            child: const Text(
              MyStr.verify,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'dana',
                fontWeight: FontWeight.w300,
                color: MySolidColors.scaffoldBack,
              ),
            )));
  }

// ! verifydialogImage
  Future<dynamic> verifydialogImage() {
    return Get.defaultDialog(
      title: '',
      content: Column(
        children: [
          Text(
            'مطمعنی میخوای تصویر رو تغییر بدی؟',
            style: Sizes.theme.bodyLarge,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await managePodcastController.storePodcastPoster();
                    Get.back();
                  },
                  child: const Text(
                    'آره حله',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'dana',
                      fontWeight: FontWeight.w300,
                      color: MySolidColors.scaffoldBack,
                    ),
                  )),
              ElevatedButton(
                  onPressed: () async {
                    filepickerController.fileImageData.value =
                        PlatformFile(name: 'nothing', size: 0);
                    Get.back();
                    await pickImagefile();
                    verifydialogImage();
                  },
                  child: const Text(
                    'تعویض میکنم',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'dana',
                      fontWeight: FontWeight.w300,
                      color: MySolidColors.scaffoldBack,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
