import 'package:flutter/material.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/gen/assets.gen.dart';

class LightThemeDecorations {
  // ! MainScreen
  static BoxDecoration mainScreenBottomNavigationBack = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: MyGradientColors.bottomNavBackColor));
  static BoxDecoration mainScreenBottomNavigationBackDark = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: MyGradientColors.bottomNavDarkBackColor));

  static BoxDecoration mainScreenBottomNavigationInside = const BoxDecoration(
      boxShadow: [BoxShadow(blurRadius: 10, color: MySolidColors.mainColor)],
      borderRadius: BorderRadius.all(Radius.circular(16)),
      gradient: LinearGradient(colors: MyGradientColors.bottomNavColor));
// !homeScreen
  static BoxDecoration homeScreenPosterFront = BoxDecoration(
      gradient: const LinearGradient(
          colors: MyGradientColors.poster,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
      borderRadius: BorderRadius.circular(25));

  static BoxDecoration homeScreenTags = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    // gradient: LinearGradient(
    //     colors: MyGradientColors.tags,
    //     begin: Alignment.topRight,
    //     end: Alignment.topLeft)
    // boxShadow: [BoxShadow(blurRadius: 1,color: MySolidColors.blackSecond)],
    color: Color.fromARGB(210, 0, 25, 50),
  );
  static BoxDecoration apFront = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      gradient: LinearGradient(
          colors: MyGradientColors.articleContainer,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter));

  // !ProfileScreen
  static BoxDecoration profileScreenPicture = BoxDecoration(
      border: Border.all(color: MySolidColors.subTitle),
      shape: BoxShape.circle,
      image: DecorationImage(
          fit: BoxFit.cover, image: Assets.images.profileImage.provider()));
  // !RegisterScreen
  static BoxDecoration registerButtomSheets = const BoxDecoration(
     
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50), topRight: Radius.circular(50)));
  static BoxDecoration registerButtomSheetsDark = const BoxDecoration(
      color: Color.fromRGBO(255, 0, 0, 0),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50), topRight: Radius.circular(50)));
  // !ArticleListScreen
  static BoxDecoration listsAppbar = BoxDecoration(
      shape: BoxShape.circle, color: MySolidColors.mainColor.withAlpha(220));
  // !ArticleInfoScreen
  static BoxDecoration articleInfoScreenAppbar = const BoxDecoration(
      gradient: LinearGradient(
          colors: MyGradientColors.articleInfoGradientColor,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter));

  static BoxDecoration articleInfoScreenTags = const BoxDecoration(
      boxShadow: [BoxShadow(blurRadius: 2, color: MySolidColors.mainColor)],
      borderRadius: BorderRadius.all(Radius.circular(16)),
      color: MySolidColors.mainColor);
  // !podcastItemScreen
  static BoxDecoration podcastItemScreenBottomNanigation = const BoxDecoration(
      boxShadow: [BoxShadow(blurRadius: 10, color: MySolidColors.mainColor)],
      borderRadius: BorderRadius.all(Radius.circular(16)),
      gradient: LinearGradient(colors: MyGradientColors.bottomNavColor));
  // !ManageArticleInfoScreen
  static BoxDecoration manageArticleInfoScreentitleUpdate = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: MySolidColors.scaffoldBack);
  static BoxDecoration manageArticleInfoScreenfilePickerButton =
      const BoxDecoration(
          color: MySolidColors.mainColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)));
  static BoxDecoration manageArticleInfoScreenbottomSheet = const BoxDecoration(
      color: MySolidColors.mainColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)));

  static BoxDecoration registerButtonSheet = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)));
}
