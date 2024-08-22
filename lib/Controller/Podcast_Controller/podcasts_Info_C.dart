// ignore_for_file: file_names, non_constant_identifier_names, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/Components/constants/api_constant.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/storage_const.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Model/podcastsModels/podcast_file_model.dart';
import 'package:techblog_project/Services/dio_services.dart';
import 'package:just_audio/just_audio.dart';

class PodcastItemController extends GetxController {
  PodcastItemController({this.id});

  RxBool loading = false.obs;
  RxList<PodcastFileModel> podcastsList = RxList();
  final player = AudioPlayer();
  late dynamic playList;
  String? id;
  RxBool playState = false.obs;
  RxBool isLoopAll = false.obs;
  RxInt currentIndex = 0.obs;
  RxDouble progressPercent = 0.0.obs;
  Timer? timer;
  Rx<Duration> progress = const Duration(seconds: 0).obs;
  Rx<Duration> buffred = const Duration(seconds: 0).obs;
  RxBool isFavorite = false.obs;
  var UserID = GetStorage().read(StorageVariables.userId);
  RxString podcast_id = RxString('');
  @override
  onInit() async {
    super.onInit();
    playList = ConcatenatingAudioSource(useLazyPreparation: true, children: []);

    await player.setAudioSource(playList,
        initialIndex: 0, initialPosition: Duration.zero);
  }

  getPodcastsInfo({required String id}) async {
    loading.value = true;
    podcastsList.clear();
 playList.clear();
     var response = await DioService().getMethod(
        '${ApiConstant.baseUrl}podcast/get.php?command=get_files&podcats_id=$id');

    if (response.statusCode == 200) {
      for (var element in response.data["files"]) {
        podcastsList.add(PodcastFileModel.fromJson(element));
        playList.add(AudioSource.uri(
            Uri.parse(PodcastFileModel.fromJson(element).file!)));
      }
      loading.value = false;
    }
  }


  progressBar() {
    Duration tick = const Duration(seconds: 1);
    int duration = player.duration!.inSeconds - player.position.inSeconds;
    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
        timer = null;
      }
    }
    timer = Timer.periodic(tick, (timer) {
      duration--;
      progress.value = player.position;
      buffred.value = player.bufferedPosition;
      if (duration <= 0) {
        timer.cancel();
        progress.value = const Duration(seconds: 0);
        buffred.value = const Duration(seconds: 0);
      }
    });
  }

  loopButtom() {
    print(isLoopAll.value);
    if (isLoopAll.value) {
      isLoopAll.value = false;
      player.setLoopMode(LoopMode.off);
    } else {
      isLoopAll.value = true;
      player.setLoopMode(LoopMode.all);
    }
  }

  timerCheck() {
    if (player.playing) {
      progressBar();
    }
  }

  bookMark() {
    if (isFavorite.value) {
      isFavorite.value = false;
    } else {
      isFavorite.value = true;
    }
  }

  storeFavoritePodcasts() async {
    Map<String, dynamic> favoriteArticleBody = {
      ApiKeyConstant.podcast_id: podcast_id.value,
      ApiKeyConstant.user_id: UserID,
      ApiKeyConstant.command: "store_favorite",
    };
    var response = await DioService()
        .postMethod(
            '${ApiConstant.baseUrl}podcast/post.php', favoriteArticleBody)
        .catchError((e) {
      Get.snackbar(MyStr.infoArticleScreenBookMarkSnackbar,
          MyStr.infoArticleScreenBookMarkMustLoginSnackbarText,
          animationDuration: const Duration(seconds: 1),
          forwardAnimationCurve: Curves.linearToEaseOut,
          backgroundColor: MySolidColors.mainColor,
          colorText: MySolidColors.scaffoldBack);
    });
    debugPrint('im up store favorite');
    debugPrint(response.data.toString());
   
    if (response.data['status_code'] == 200) {
      Get.snackbar(MyStr.infoArticleScreenBookMarkSnackbar,
          MyStr.infoArticleScreenBookMarkSuccessSnackbarText,
          animationDuration: const Duration(seconds: 1),
          forwardAnimationCurve: Curves.linearToEaseOut,
          backgroundColor: MySolidColors.mainColor,
          colorText: MySolidColors.scaffoldBack);
    } else {
      Get.snackbar(MyStr.infoArticleScreenBookMarkSnackbar,
          MyStr.infoArticleScreenBookMarkSupportSnackbarText,
          animationDuration: const Duration(seconds: 1),
          forwardAnimationCurve: Curves.linearToEaseOut,
          backgroundColor: MySolidColors.mainColor,
          colorText: MySolidColors.scaffoldBack);
    }
  }
}
