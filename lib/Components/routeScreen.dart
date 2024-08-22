// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:techblog_project/View/Favorite/articles/articleFavoriteList_S.dart';
import 'package:techblog_project/View/Favorite/articles/articleFavorite_Info_S.dart';
import 'package:techblog_project/View/Favorite/podcasts/podcasts_Favorite_Info_S.dart';
import 'package:techblog_project/View/Favorite/podcasts/podcasts_Favorite_List_S.dart';
import 'package:techblog_project/View/RegesterScreens/register_S.dart';
import 'package:techblog_project/View/articleScreens/mainArticleScreen/articleList_S.dart';
import 'package:techblog_project/View/articleScreens/mainArticleScreen/article_info_S.dart';
import 'package:techblog_project/View/articleScreens/manageArticle/manage_Article_Info_S.dart';
import 'package:techblog_project/View/articleScreens/manageArticle/editarticle/manage_Article_Info_edit_S.dart';
import 'package:techblog_project/View/articleScreens/manageArticle/manage_Article_S.dart';
import 'package:techblog_project/View/mainPages/home_S.dart';
import 'package:techblog_project/View/mainPages/main_S.dart';
import 'package:techblog_project/View/mainPages/profile_S.dart';
import 'package:techblog_project/View/mainPages/search_S.dart';
import 'package:techblog_project/View/podcastScreens/managePodcast/editPodcast/manage_podcast_Info_edit_S.dart';
import 'package:techblog_project/View/podcastScreens/managePodcast/manage_Podcast_Info_S.dart';
import 'package:techblog_project/View/podcastScreens/managePodcast/manage_podcast_list_S.dart';
import 'package:techblog_project/View/podcastScreens/mainPodcastScreen/podcast_List_S.dart';
import 'package:techblog_project/View/podcastScreens/mainPodcastScreen/podcast_Item_S.dart';
import 'package:techblog_project/View/splash_S.dart';
import 'package:techblog_project/binding.dart';

class RouteScreens {
    static const String routeSearchScreen = '/searchScreen';
  static const String routeMainScreen = '/mainScreen';
  static const String routeHomeScreen = '/homescreen';
  static const String routeArticleFavoriteListscreen =
      '/routeArticleFavoriteListscreen';
  static const String routeArticleFavoriteInfoscreen =
      '/articleFavoriteInfoController';
  static const String podcastFavoriteListScreen = '/podcastFavoriteListScreen';
  static const String podcastFavoriteInfoScreen = '/podcastFavoriteInfoScreen';
  static const String routeSplashScreen = '/splashScreen';
  static const String routeProfileScreen = '/profileScreen';
  static const String routeSelectCatScreen = '/SelectCatScreen';
  static const String routeRegisterScreen = '/RegisterScreen';
  static const String routeManageArticleScreen = '/ManageArticle';
  static const String manageArticleInfoScreen = '/ManageArticleInfoScreen';
  static const String routeArticleListScreen = '/ArticleListScreen';
  static const String routeArticleInfoScreen = '/ArticleInfoScreen';
  static const String routeManageArticleInfoEditScreen =
      '/ManageArticleInfoEditScreen';
//  !Podcasts
  static const String routePodcastListScreen = '/PodcastListScreen';
  static const String routePodcastItemScreen = '/PodcastItemScreen';
//  !Podcasts manage
  static const String routeManagePodcastListScreen = '/ManagePodcastListScreen';
  static const String routeManagePodcastInfoScreen = '/ManagePodcastInfoScreen';
  static const String routeManagePodcastInfoEditScreen =
      '/ManagePodcastInfoEditScreen';
}

class InMAinRouteScreen {
  InMAinRouteScreen._();
  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: RouteScreens.routeSearchScreen,
      page: () => SearchScreen(),
      binding: SearchBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.routeManagePodcastListScreen,
      page: () => ManagePodcastListScreen(),
      binding: ManagePodcastBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.routeManagePodcastInfoEditScreen,
      page: () => ManagePodcastInfoEditScreen(),
      binding: ManagePodcastBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.routeManagePodcastInfoScreen,
      page: () => ManagePodcastInfoScreen(),
      binding: ManagePodcastBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.routeManageArticleInfoEditScreen,
      page: () => ManageArticleInfoEditScreen(),
      binding: ManageArticleBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),

    GetPage(
        name: RouteScreens.routeHomeScreen,
        page: () => HomeScreen(),
        binding: HomescreenBinding()),
    // !Favorite
    GetPage(
      name: RouteScreens.routeArticleFavoriteListscreen,
      page: () => ArticleFavoriteListScreen(),
      binding: ArticleFavoritebinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.routeArticleFavoriteInfoscreen,
      page: () => ArticleFavoriteInfoScreen(),
      binding: ArticleFavoritebinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.podcastFavoriteListScreen,
      page: () => PodcastFavoriteListScreen(),
      binding: PodcastFavoritebinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.podcastFavoriteInfoScreen,
      page: () => PodcastFavoriteInfoScreen(),
      binding: PodcastFavoritebinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.routeMainScreen,
      page: () => const MainScreen(),
      binding: HomescreenBinding(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: RouteScreens.routeSplashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteScreens.routeProfileScreen,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    // GetPage(
    //   name: routeScreens.routeSelectCatScreen,
    //   page: () =>  SignUpSuccessfully(),
    // ),
    GetPage(
      name: RouteScreens.routeRegisterScreen,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.routeArticleListScreen,
      page: () => ArticleListScreen(),
      binding: ArticleBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.routeArticleInfoScreen,
      page: () => ArticleInfoScreen(),
      binding: ArticleBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.routeManageArticleScreen,
      page: () => ManageArtiScreen(),
      binding: ManageArticleBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.manageArticleInfoScreen,
      page: () => ManageArticleInfoScreen(),
      binding: ManageArticleBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.routePodcastListScreen,
      page: () => PodcastListScreen(),
      binding: PodcastListbinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: RouteScreens.routePodcastItemScreen,
      page: () => PodcastItemScreen(),
      binding: PodcastListbinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
    )
  ];
}
