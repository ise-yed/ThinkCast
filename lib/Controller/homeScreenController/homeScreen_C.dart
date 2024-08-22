// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Model/articleModels/article_Model.dart';
import 'package:techblog_project/Model/podcastsModels/podcast_Model.dart';
import 'package:techblog_project/Model/poster_Model.dart';
import 'package:techblog_project/Model/tags_model.dart';
import 'package:techblog_project/Services/dio_services.dart';

class HomeScreenController extends GetxController {
  RxList<TagsModel> tagsList = RxList();
  Rx<PosterModel>? posterData = PosterModel().obs;
  RxList<PodcastModel> topPodcasts = RxList();
  RxList<ArticleModel> topVisited = RxList();
  RxBool homeScreenLoading = false.obs;
  RxBool posterArticleState = RxBool(false);
  RxBool posterPodcastState = RxBool(false);
  RxInt posterState = 0.obs;

  @override
  onInit() {
    super.onInit();
    getHomeData();


  }

  getHomeData() async {
    topVisited.clear();
    topPodcasts.clear();

    homeScreenLoading.value = true;
    var response = await DioService().getMethod('https://thinkcast.ir/api/home/?command=index');
    if (response.statusCode == 200) {
      // response.data['top_visited'].forEach((element) {
      //   topVisited.add(ArticleModel.fromJson(element));
      // });
      for (var element in response.data['top_visited']) {
        topVisited.add(ArticleModel.fromJson(element));
      }
      for (var el in response.data['top_podcasts']) {
        topPodcasts.add(PodcastModel.fromjson(el));
      }
     
      for (var elm in response.data['tags']) {
        tagsList.add(TagsModel.fromJson(elm));
      }
    
      posterData!.value = PosterModel.fromJson(response.data['poster']);
      homeScreenLoading.value = false;
    }
  }
}