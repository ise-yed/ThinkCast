// ignore_for_file: file_names, avoid_print

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/Components/constants/api_constant.dart';
import 'package:techblog_project/Components/constants/command_constant.dart';
import 'package:techblog_project/Components/constants/storage_const.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_Info_C.dart';
import 'package:techblog_project/Controller/filePicker_C.dart';
import 'package:techblog_project/Model/podcastsModels/podcast_Model.dart';
import 'package:techblog_project/Services/dio_services.dart';
import 'package:dio/dio.dart' as dios;

class ManagePodcastController extends GetxController {
  RxList<PodcastModel> podcastList = RxList();
  // Rx<PodcastModel> podcastInfoList = PodcastModel().obs;
  Rx<PodcastModel> podcastInfoEditList = PodcastModel().obs;
  Rx<TextEditingController> titletextEditingController =
      TextEditingController().obs;
  TextEditingController filetitleTextEditingController =
      TextEditingController();
  RxInt numberpickerSecondValue = 2.obs;
  RxInt numberpickerMinuteValue = 2.obs;
  String? podcastId;
  final podcastItemController = Get.find<PodcastItemController>();
  final filePickercontroller = Get.find<FilePickerController>();
  RxString imagepath = RxString('');
  int? filelengh;
  RxString fileID = ''.obs;
  var userid = GetStorage().read(StorageVariables.userId);

  @override
  void onInit() {
    super.onInit();
    getDataManagePodcasts();
  }

  getDataManagePodcasts() async {
    print(userid);
    podcastList.clear();

    var response = await DioService().getMethod(
        'https://thinkcast.ir/api/podcast/get.php?command=published_by_me&user_id=$userid');
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        podcastList.add(PodcastModel.fromjson(element));
      });
    }
  }

  deletePodcast(String id) async {
    Map<String, dynamic> map = {
      ApiKeyConstant.podcast_id: id,
      ApiKeyConstant.user_id: userid,
      ApiKeyConstant.command: CommandConstant.delete
    };
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}podcast/post.php', map);

    debugPrint(response.toString());
  }

  deleteFilePodcast({required String id}) async {
    Map<String, dynamic> map = {
      ApiKeyConstant.file_id: id,
      ApiKeyConstant.command: CommandConstant.delete_file
    };
    var response = await DioService().postMethod(
        '${ApiConstant.baseUrl}podcast/post.php?command=delete_file', map);
    debugPrint(response.toString());
  }

  storetitle() async {
    Map<String, dynamic> map = {
      // todo: must change it with user id
      ApiKeyConstant.user_id: userid,
      ApiKeyConstant.title: titletextEditingController.value.text,
      ApiKeyConstant.cat_id: 1,
      ApiKeyConstant.command: CommandConstant.store_title
    };
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}podcast/post.php', map);

    podcastId = (response.data['data']['podcast_id']);
    debugPrint(response.data['data']['podcast_id']);
  }

// !storePodcastFile
  storePodcastFile() async {
    debugPrint(podcastId);
    debugPrint(titletextEditingController.value.text);
    debugPrint(numberpickerMinuteValue.value.toString());
    debugPrint(dios.MultipartFile.fromFile(
            filePickercontroller.fileAudioData.value.path!)
        .toString());
    Map<String, dynamic> map = {
      // todo: must change it with user id

      ApiKeyConstant.podcast_id: podcastId,
      ApiKeyConstant.command: CommandConstant.store_file,
      ApiKeyConstant.title: filePickercontroller.fileAudioData.value.name,
      ApiKeyConstant.length: numberpickerMinuteValue.value,
      ApiKeyConstant.file: await dios.MultipartFile.fromFile(
          filePickercontroller.fileAudioData.value.path!),
    };
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}podcast/post.php', map);

    debugPrint(response.toString());
  }

  // !storePodcastPoster
  storePodcastPoster() async {
    Map<String, dynamic> map = {
      // todo: must change it with user id
      ApiKeyConstant.user_id: userid,
      ApiKeyConstant.podcast_id: podcastId,
      // todo: must if statement
      ApiKeyConstant.image: await dios.MultipartFile.fromFile(
          filePickercontroller.fileImageData.value.path!),
      ApiKeyConstant.command: CommandConstant.update_poster
    };
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}podcast/post.php', map);

    debugPrint(response.toString());
  }

// !updatePodcastPoster
  updatePodcastPoster() async {
    Map<String, dynamic> map = {
      ApiKeyConstant.user_id: userid,
      ApiKeyConstant.podcast_id: podcastInfoEditList.value.id,
      ApiKeyConstant.image: await dios.MultipartFile.fromFile(
          filePickercontroller.fileImageData.value.path!),
      ApiKeyConstant.command: CommandConstant.update_poster
    };
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}podcast/post.php', map);

    debugPrint(response.toString());
  }

  // !updatePodcastFile
  updatePodcastFile(
    String fileID,
    String loc,
  ) async {
    Map<String, dynamic> map = {
      ApiKeyConstant.file_id: fileID,
      ApiKeyConstant.file: await dios.MultipartFile.fromFile(
          filePickercontroller.fileAudioData.value.path!),
      ApiKeyConstant.command: CommandConstant.update_file,
      ApiKeyConstant.title: filePickercontroller.fileAudioData.value.name,
      ApiKeyConstant.length: numberpickerMinuteValue.value,
    };
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}podcast/post.php', map);

    debugPrint(response.toString());
  }

// !storePodcastFile
  storePodcastFileInEdit() async {
    debugPrint(podcastId);
    debugPrint(titletextEditingController.value.text);
    debugPrint(numberpickerMinuteValue.value.toString());
    debugPrint(dios.MultipartFile.fromFile(
            filePickercontroller.fileAudioData.value.path!)
        .toString());
    Map<String, dynamic> map = {
      ApiKeyConstant.podcast_id: podcastInfoEditList.value.id,
      ApiKeyConstant.command: CommandConstant.store_file,
      ApiKeyConstant.title: filePickercontroller.fileAudioData.value.name,
      ApiKeyConstant.length: numberpickerMinuteValue.value,
      ApiKeyConstant.file: await dios.MultipartFile.fromFile(
          filePickercontroller.fileAudioData.value.path!),
    };
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}podcast/post.php', map);

    debugPrint(response.toString());
  }

  // !updatePodcastTitle
  updatetitles() async {
    Map<String, dynamic> map = {
      ApiKeyConstant.user_id: userid,
      ApiKeyConstant.podcast_id: podcastInfoEditList.value.id,
      ApiKeyConstant.title: titletextEditingController.value.text,
      ApiKeyConstant.cat_id: 1,
      ApiKeyConstant.command: CommandConstant.update_title
    };
    // ignore: unused_local_variable
    var response = await DioService()
        .postMethod('${ApiConstant.baseUrl}podcast/post.php', map);
  }

  clearVariables() {
    filePickercontroller.fileAudioData.value =
        PlatformFile(name: 'nothing', size: 0);
    filePickercontroller.fileImageData.value =
        PlatformFile(name: 'nothing', size: 0);
    // ignore: avoid_single_cascade_in_expression_statements
    titletextEditingController..value.text = '';
    podcastItemController.podcastsList.clear();
  }
}
