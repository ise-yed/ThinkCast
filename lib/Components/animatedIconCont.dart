// ignore_for_file: file_names, unnecessary_import

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
final ThemeController themeController = Get.find();

Widget themeModeIcon(){
return AnimateIcon(
                                      key: UniqueKey(),
                                      onTap: () { themeController.toggleTheme();},
                                      iconType: IconType.continueAnimation,
                                      width: 20,
                                      color: themeController.isDarkMode.value ==
                                              false
                                          ? Colors.black
                                          : Colors.white,
                                      animateIcon: AnimateIcons.dayNightWeather,
                                      toolTip: 'صفحه مقالات',
                                    );}
                                    Widget profileIcon(){
return AnimateIcon(
                                      key: UniqueKey(),
                                      onTap: () {    Get.toNamed(RouteScreens.routeProfileScreen);},
                                      iconType: IconType.continueAnimation,
                                      width: 20,
                                      color: themeController.isDarkMode.value ==
                                              false
                                          ? Colors.black
                                          : Colors.white,
                                      animateIcon: AnimateIcons.wink,
                                      toolTip: 'صفحه مقالات',
                                    );}
                                    Widget shareIcon(){
return AnimateIcon(
                                      key: UniqueKey(),
                                      onTap: () {},
                                      iconType: IconType.continueAnimation,
                                      width: 20,
                                      color: themeController.isDarkMode.value ==
                                              false
                                          ? Colors.black
                                          : Colors.white,
                                      animateIcon: AnimateIcons.share,
                                      toolTip: 'صفحه مقالات',
                                    );}
                                    Widget netIcon(){
return AnimateIcon(
                                      key: UniqueKey(),
                                      onTap: () {},
                                      iconType: IconType.continueAnimation,
                                      width: 20,
                                      color: themeController.isDarkMode.value ==
                                              false
                                          ? Colors.black
                                          : Colors.white,
                                      animateIcon: AnimateIcons.internet,
                                      toolTip: 'صفحه مقالات',
                                    );}
                                    Widget exitIcon(){
return AnimateIcon(
                                      key: UniqueKey(),
                                      onTap: () {},
                                      iconType: IconType.continueAnimation,
                                      width: 20,
                                      color: themeController.isDarkMode.value ==
                                              false
                                          ? Colors.black
                                          : Colors.white,
                                      animateIcon: AnimateIcons.signOut,
                                      toolTip: 'صفحه مقالات',
                                    );}
                                     Widget profileMainIcon(){
return AnimateIcon(
                                      key: UniqueKey(),
                                      onTap: () {    Get.toNamed(RouteScreens.routeProfileScreen);},
                                      iconType: IconType.continueAnimation,
                                      width: 40,
                                      color: themeController.isDarkMode.value ==
                                              false
                                          ? Colors.black
                                          : Colors.white,
                                      animateIcon: AnimateIcons.wink,
                                      toolTip: 'صفحه مقالات',
                                    );}