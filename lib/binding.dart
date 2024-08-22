import 'package:get/get.dart';

import 'package:techblog_project/Controller/Favorite/Podcasts/podcasts_Favorite_Info_C.dart';
import 'package:techblog_project/Controller/Favorite/Podcasts/podcasts_Favorite_List_C.dart';
import 'package:techblog_project/Controller/Favorite/articles/ArticleFavorite_Info_C.dart';
import 'package:techblog_project/Controller/Podcast_Controller/managePodcast_C.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_List_C.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_Info_C.dart';
import 'package:techblog_project/Controller/article_controller/articleInfo_C.dart';
import 'package:techblog_project/Controller/article_controller/articleList_S_C.dart';

import 'package:techblog_project/Controller/article_controller/manageArticle_C.dart';
import 'package:techblog_project/Controller/filePicker_C.dart';
import 'package:techblog_project/Controller/homeScreenController/homeScreen_C.dart';
import 'package:techblog_project/Controller/Favorite/articles/ArticleFavoriteList_C.dart';
import 'package:techblog_project/Controller/homeScreenController/searchScreen_C.dart';
import 'package:techblog_project/Controller/regesterController/register_C.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/Controller/userController/user_C.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegesterController());
    Get.put(UserController());
  }
}

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SearchScreenController());
    Get.put(PodcastListController());
    Get.put(ThemeController());
  }
}

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
    Get.put(ThemeController());
  
    // Get.put(FilePickerController());
  }
}

class HomescreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
    Get.put(
      ArticleInfoController(),
    );
    Get.put(
      ArticleListController(),
    );
    Get.put(
      UserController(),
    );
    Get.put(PodcastItemController());
    Get.put(FilePickerController());
  }
}

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ArticleListController());
    Get.put(ArticleInfoController());
    Get.put(ThemeController());
  }
}

class ManageArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ManageArticleController());
    Get.put(ArticleInfoController());
    Get.put(ThemeController());
    Get.lazyPut(() => FilePickerController());
  }
}

class ManagePodcastBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PodcastItemController());
    Get.put(ManagePodcastController());
    Get.put(ThemeController());

    Get.lazyPut(() => FilePickerController());
  }
}

class PodcastListbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PodcastListController());
    Get.put(PodcastItemController());
    Get.put(ThemeController());
  }
}

class ArticleFavoritebinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ArticleFavoriteListController());
    Get.put(ArticleFavoriteInfoController());
    Get.put(ThemeController());
    Get.put(PodcastListController());
  }
}

class PodcastFavoritebinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PodcastFavoriteListController());
    Get.put(PodcastFavoriteInfoController());
    Get.put(ThemeController());
    Get.put(PodcastListController());
  }
}
