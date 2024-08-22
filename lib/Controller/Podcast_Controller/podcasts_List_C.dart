// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/Components/constants/api_constant.dart';
import 'package:techblog_project/Components/constants/storage_const.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Model/podcastsModels/podcast_Model.dart';
import 'package:techblog_project/Services/dio_services.dart';

class PodcastListController extends GetxController {
  RxString appbarText = RxString(MyStr.intioalPodcastAppbarText);
  RxList<PodcastModel> podcastList = RxList();
  var userId = GetStorage().read(StorageVariables.userId);

  @override
  void onInit() {
    super.onInit();
    getPodcastsList();
    debugPrint('im from inint');
  }

  Future getPodcastsList() async {
    podcastList.clear();
    var response = await DioService().getMethod(
        '${ApiConstant.baseUrl}podcast/get.php?command=new&user_id=$userId');

    debugPrint(response.data.toString());

    response.data.forEach((element) {
      podcastList.add(PodcastModel.fromjson(element));
    });
  }
}
