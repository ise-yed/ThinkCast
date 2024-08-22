// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:techblog_project/Model/articleModels/article_Model.dart';
import 'package:techblog_project/Model/podcastsModels/podcast_Model.dart';
import 'package:techblog_project/Services/dio_services.dart';

class SearchScreenController extends GetxController {
  RxList<PodcastModel> resultPodcasts = RxList();
  RxList<ArticleModel> resultArticles = RxList();
  RxBool loading = false.obs;
  RxInt toggleState = 0.obs;
  RxString searchText = RxString('0');

  getArticleData() async {
    loading.value = true;
    var response = await DioService().getMethod('');
    if (response.statusCode == 200) {
  
      for (var element in response.data['top_visited']) {
        resultArticles.add(ArticleModel.fromJson(element));
      }
      for (var el in response.data['top_podcasts']) {
        resultPodcasts.add(PodcastModel.fromjson(el));
      }
    
      loading.value = false;
    }
  }
    getPodcastData() async {
    loading.value = true;
    var response = await DioService().getMethod('');
    if (response.statusCode == 200) {
  
      for (var element in response.data['top_visited']) {
        resultArticles.add(ArticleModel.fromJson(element));
      }
      for (var el in response.data['top_podcasts']) {
        resultPodcasts.add(PodcastModel.fromjson(el));
      }
    
      loading.value = false;
    }
  }
}
