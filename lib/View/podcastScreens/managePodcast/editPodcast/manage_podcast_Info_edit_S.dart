// ignore_for_file: file_names

import 'package:avatar_glow/avatar_glow.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:techblog_project/Components/animatedIconCont.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Components/themes/decoration.dart';
import 'package:techblog_project/Components/themes/theme_text_style.dart';
import 'package:techblog_project/Controller/Podcast_Controller/managePodcast_C.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_Info_C.dart';
import 'package:techblog_project/Controller/filePicker_C.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/Services/filePicker_services.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/gen/assets.gen.dart';

class ManagePodcastInfoEditScreen extends StatelessWidget {
  ManagePodcastInfoEditScreen({super.key});
  final ThemeController themeController = Get.find();

  final managePodcastController = Get.find<ManagePodcastController>();
  final podcastItemController = Get.find<PodcastItemController>();
  // todo:bad performance
  final filepickerController = Get.find<FilePickerController>();

  @override
  Widget build(BuildContext context) {
    managePodcastController.imagepath.value =
        managePodcastController.podcastInfoEditList.value.poster!;

    managePodcastController.titletextEditingController.value.text =
        managePodcastController.podcastInfoEditList.value.title!;
    podcastItemController.getPodcastsInfo(
        id: managePodcastController.podcastInfoEditList.value.id!);

    debugPrint('im id');

    debugPrint(managePodcastController.podcastInfoEditList.value.id);
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Stack(
                  children: [
                    infosPosterImage(
                        controller: managePodcastController
                            .podcastInfoEditList.value.poster!),
                    managepodcastInfoScreenAppBar(
                        managePodcastController: managePodcastController,
                        podcastItemController: podcastItemController),
                    filePickerButton(),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    PodcastEditText(),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => Text(
                        managePodcastController
                            .podcastInfoEditList.value.title!,
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
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AddPodcastFile(
                            managePodcastController: managePodcastController,
                            podcastItemController: podcastItemController,
                            addPodcastFileButton: SizedBox(
                              height: 50,
                              width: 400,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await managePodcastController
                                        .storePodcastFileInEdit();
                                    filepickerController.fileAudioData.value =
                                        PlatformFile(name: 'nothing', size: 0);
                                    Get.offAllNamed(
                                        RouteScreens.routeSplashScreen);
                                  },
                                  child: const Text(MyStr.verify,
                                      style: TextStyle(
                                          fontFamily: "dana",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: MySolidColors.scaffoldBack))),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: AvatarGlow(
                            animate: true,
                            glowRadiusFactor: 0.4,
                            glowColor: themeController.isDarkMode.value == false
                                ? MySolidColors.mainColor
                                : Colors.white,
                            child: profileMainIcon(),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                    // !Show File Section
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 5,
                                    color: MySolidColors.mainColor)
                              ],
                              borderRadius: BorderRadius.circular(30),
                              color: themeController.isDarkMode.value == false
                                  ? Colors.white
                                  : const Color.fromARGB(255, 1, 10, 24)),
                          height: Sizes.size.height / 3.3,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                podcastItemController.podcastsList.length,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  await podcastItemController.player
                                      .seek(Duration.zero, index: index);
                                  podcastItemController.currentIndex.value =
                                      podcastItemController
                                          .player.currentIndex!;

                                  podcastItemController.timerCheck();
// ! set file title to controller
                                  managePodcastController
                                          .filetitleTextEditingController.text =
                                      podcastItemController
                                          .podcastsList[index].title!;

                                  managePodcastController.fileID.value =
                                      podcastItemController
                                          .podcastsList[index].id!;
                                  debugPrint('im file iddd');
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 16, bottom: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ImageIcon(
                                          Assets.icons.morepodcast.provider(),
                                          color: MySolidColors.blueTitle,
                                          size: 20,
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: themeController
                                                                  .isDarkMode
                                                                  .value ==
                                                              false
                                                          ? Colors.black
                                                          : Colors.white),
                                            ),
                                          ),
                                        ),

                                        editPodcastFile(
                                            podcastItemController
                                                .podcastsList[index].id!,
                                            podcastItemController
                                                .podcastsList[index].file!,
                                            podcastItemController
                                                .podcastsList[index].title!),

                                        // await managePodcastController.
                                        //     updatePodcastFile(podcastItemController.podcastsList[index].id!,
                                        //     );

                                        IconButton(
                                            onPressed: () async {
                                              // todo:must Check it when add file podcast
                                              // ! must Check it when add file podcast
                                              await managePodcastController
                                                  .deleteFilePodcast(
                                                      id: podcastItemController
                                                          .podcastsList[index]
                                                          .id!);

                                              podcastItemController
                                                  .getPodcastsInfo(
                                                      id: managePodcastController
                                                          .podcastInfoEditList
                                                          .value
                                                          .id!);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 25,
                                              color: Colors.red,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // player
          player(podcastItemController: podcastItemController),
        ]),
      ),
    );
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
                pickImagefile();
                // !verifydialogImage
                Future.delayed(const Duration(seconds: 2)).then(
                  (value) {
                    verifydialogImage();
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    MyStr.selectImage,
                    style: Sizes.theme.headlineMedium,
                  ),
                  const Icon(
                    Icons.add,
                    color: MySolidColors.scaffoldBack,
                    size: 25,
                  )
                ],
              ),
            ),
          ),
        ));
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
                    await managePodcastController.updatePodcastPoster();
                    Get.back();
                  },
                  child: const Text('آره حله',
                      style: TextStyle(
                          fontFamily: "dana",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: MySolidColors.scaffoldBack))),
              ElevatedButton(
                  onPressed: () async {
                    filepickerController.fileImageData.value =
                        PlatformFile(name: 'nothing', size: 0);
                    Get.back();
                    await pickImagefile();
                    verifydialogImage();
                  },
                  child: const Text('تعویض میکنم',
                      style: TextStyle(
                          fontFamily: "dana",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: MySolidColors.scaffoldBack))),
            ],
          )
        ],
      ),
    );
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
        title: MyStr.titleArticleEditText,
        titleStyle: Sizes.theme.displayMedium,
        content: Container(
          decoration: LightThemeDecorations.manageArticleInfoScreentitleUpdate,
          child: TextField(
            controller:
                managePodcastController.titletextEditingController.value,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              hintText: managePodcastController.podcastInfoEditList.value.title,
            ),
            style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.text,
          ),
        ),
        radius: 15,
        confirm: ElevatedButton(
            onPressed: () async {
              await managePodcastController.updatetitles();
              managePodcastController.podcastInfoEditList.value.title =
                  managePodcastController.titletextEditingController.value.text;
              Get.back();
            },
            child: const Text(MyStr.verify,
                style: TextStyle(
                    fontFamily: "dana",
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: MySolidColors.scaffoldBack))));
  }

  // !  editPodcastFile
  // ignore: non_constant_identifier_names
  InkWell editPodcastFile(String fileID, String loc, String titlefile) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            Container(
              width: Sizes.size.width,
              height: Sizes.size.height / 2.1,
              decoration: LightThemeDecorations.registerButtonSheet,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 16, left: 16, right: 16),
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
                            MyStr.podcastFileEditText,
                            style: AppTheme.lightTheme.textTheme.titleLarge,
                          )
                        ],
                      ),

                      // SizedBox(
                      //   height: 55,
                      //   child: TextField(
                      //     controller: managePodcastController
                      //         .filetitleTextEditingController,
                      //     decoration: InputDecoration(
                      //       border: const OutlineInputBorder(
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(20))),
                      //       hintText: titlefile,
                      //     ),
                      //     style: const TextStyle(color: Colors.black),
                      //     keyboardType: TextInputType.text,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ! part 1
                          GestureDetector(
                            onTap: () async {
                              debugPrint('im from seledt Podcast');
                              await pickAudioFile();
                              managePodcastController
                                      .filetitleTextEditingController.text =
                                  filepickerController.fileAudioData.value.name;
                              debugPrint(filepickerController
                                  .fileAudioData.value.name);
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
                      // !selectAudioButton
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: ElevatedButton(
                            onPressed: () async {
                              debugPrint(fileID);
                              debugPrint(loc);

                              debugPrint(filepickerController
                                  .fileAudioData.value.size
                                  .toString());
                              debugPrint(managePodcastController
                                  .filetitleTextEditingController.text);
                              await managePodcastController.updatePodcastFile(
                                  fileID, loc);
                              Get.offAllNamed(RouteScreens.routeSplashScreen);
                            },
                            child: const Text(MyStr.verify,
                                style: TextStyle(
                                    fontFamily: "dana",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: MySolidColors.scaffoldBack))),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
      child: const Icon(
        Icons.change_circle_rounded,
        color: MySolidColors.blueTitle,
      ),
    );
  }
}
