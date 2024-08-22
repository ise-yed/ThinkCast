// ignore_for_file: unrelated_type_equality_checks, file_names, depend_on_referenced_packages, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techblog_project/Components/animatedIconCont.dart';

import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Components/themes/decoration.dart';
import 'package:techblog_project/Controller/Podcast_Controller/podcasts_Info_C.dart';
import 'package:techblog_project/Controller/regesterController/register_C.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/Controller/userController/user_C.dart';
import 'package:techblog_project/gen/assets.gen.dart';
import 'package:techblog_project/View/mainPages/home_S.dart';
import 'package:techblog_project/View/mainPages/profile_S.dart';
import 'package:techblog_project/View/RegesterScreens/register_S.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:icon_animated/icon_animated.dart';
import 'package:url_launcher/url_launcher.dart';

final userController = Get.find<UserController>();
final podcastItemController = Get.find<PodcastItemController>();
final GlobalKey<ScaffoldState> _key = GlobalKey();
var selectedPageIndex = 0.obs;
var selectedPageState = 0.obs;
const String url = 'https://beacons.ai/ise_yed';

final ThemeController themeController = Get.find();

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        drawer: drawer(context, themeController),
        key: _key,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          title: appbars(),
        ),
        body: Stack(
          children: [
            Center(
              child: Obx(() {
                return IndexedStack(
                  index: selectedPageIndex.value,
                  children: [
                    HomeScreen(),
                    ProfileScreen(),
                    RegisterScreen(),
                  ],
                );
              }),
            ),
            floatingPlayerButton(podcastItemController: podcastItemController),
            
            buttonNavigator(switchScreens: (int value) {
              selectedPageIndex.value = value;
            }),
          ],
        ),
      ),
    );
  }

  void _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Drawer drawer(BuildContext context, ThemeController themeController) {
    return Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: Padding(
        padding:  const EdgeInsets.only(left: 35, right: 35),
        child: ListView(
          children: [
            DrawerHeader(
              child: SvgPicture.asset(color:  themeController.isDarkMode != false?
                  
                   Colors.white:
                   MySolidColors.mainColor,
                Assets.images.logo.toString(),
                height: Sizes.size.height / 0.8,
                width: Sizes.size.width / 1,
              ),
            ),
            GestureDetector(
              onTap: () {
                themeController.toggleTheme();
              },
              child: ListTile(
                title: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   themeModeIcon(),const SizedBox(width:5),
                    Text(
                      themeController.isDarkMode.value == false
                          ? MyStr.darkModeDrawerText
                          : MyStr.lightModeDrawerText,
                      style: TextStyle(
                          fontFamily: "dana",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: themeController.isDarkMode.value == false
                              ? Colors.black
                              : Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const DDivider(),
            ListTile(
              title: InkWell(
                onTap: () {
                  Get.toNamed(RouteScreens.routeProfileScreen);
                },
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [profileIcon(),const SizedBox(width:5),
                    Text(
                      MyStr.profileDrawerText,
                      style: TextStyle(
                          fontFamily: "dana",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: themeController.isDarkMode.value == false
                              ? Colors.black
                              : Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            // const DDivider(),
            // ListTile(
            //   title: Text(
            //     MyStr.aboutDrawerText,
            //     style: TextStyle(
            //         fontFamily: "dana",
            //         fontSize: 15,
            //         fontWeight: FontWeight.w700,
            //         color: themeController.isDarkMode.value == false
            //             ? Colors.black
            //             : Colors.white),
            //   ),
            // ),
            const DDivider(),
            ListTile(
              title: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [shareIcon(),const SizedBox(width:5),
                  Text(
                    MyStr.shareDrawerText,
                    style: TextStyle(
                        fontFamily: "dana",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: themeController.isDarkMode.value == false
                            ? Colors.black
                            : Colors.white),
                  ),
                ],
              ),
              onTap: () async {
                await Share.share(MyStr.sharevalueDrawerText);
              },
            ),
            const DDivider(),
            ListTile(
              title: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [netIcon(),const SizedBox(width:5),
                  Text(
                    MyStr.instagramDrawerText,
                    style: TextStyle(
                        fontFamily: "dana",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: themeController.isDarkMode.value == false
                            ? Colors.black
                            : Colors.white),
                  ),
                ],
              ),
              onTap: () {
                _launchURL();
              },
            ),
            const DDivider(),
            ListTile(
              title: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [exitIcon(),const SizedBox(width: 5,),
                  Text(
                    MyStr.exit,
                    style: TextStyle(
                        fontFamily: "dana",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: themeController.isDarkMode.value == false
                            ? Colors.black
                            : Colors.white),
                  ),
                ],
              ),
              onTap: () {
                _restartApp();
              },
            ),
            const DDivider(),
          ],
        ),
      ),
    );
  }

  Widget appbars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
                  _key.currentState!.openDrawer();
          },
          child: Obx(
            () => IconAnimated(
              color: themeController.isDarkMode == false
                  ? Colors.black
                  : Colors.white,
              active: userController.appbarIconStatus.value,
              size: 40,
              iconType: IconType.menu,
            ),
          ),
        ),
        SvgPicture.asset( color:  themeController.isDarkMode != false?
                  
                   Colors.white:
                   MySolidColors.mainColor,
          Assets.images.logo.toString(),
          height: Sizes.size.height / 4.5,
          // width: Sizes.size.width / 1,
        ),
        // const SizedBox(
        //   width: 50,
        // ),

        Obx(
          () => GestureDetector(
            onTap: () {
              // userController.appbarSearchStatus.value = true;
              // print(userController.appbarSearchStatus.value);
              Get.toNamed(RouteScreens.routeSearchScreen);
            },
            child: IconAnimated(
              color: themeController.isDarkMode == false
                  ? Colors.black
                  : Colors.white,
              active: userController.appbarIconStatus.value,
              size: 40,
              iconType: IconType.search,
            ),
          ),
        ),
      ],
    );
  }

  void _restartApp() {
    if (Platform.isAndroid || Platform.isIOS) {
      exit(0); // Exit the app on Android or iOS
    } else {
      throw UnsupportedError(
          'Restarting the app is not supported on this platform.');
    }
  }
}

Widget buttonNavigator({required Null Function(int value) switchScreens}) {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Obx(
      () => Container(
        height: 62,
        decoration: themeController.isDarkMode.value == false
            ? LightThemeDecorations.mainScreenBottomNavigationBack
            : LightThemeDecorations.mainScreenBottomNavigationBackDark,
        child: Padding(
          padding: EdgeInsets.only(
              top: 0,
              left: Sizes.widthsize + 20,
              right: Sizes.widthsize + 20,
              bottom: 5),
          child: Container(
            decoration: LightThemeDecorations.mainScreenBottomNavigationInside,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        switchScreens(0);
                        selectedPageState.value = 0;
                      },
                      child: ImageIcon(
                        Assets.icons.home.provider(),
                        size: 25,
                        color: MySolidColors.scaffoldBack,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    selectedPageState.value == 0
                        ? Opacity(
                            opacity: 1,
                            child: Container(
                              height: 5,
                              width: 32,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                          )
                        : Opacity(
                            opacity: 0.05,
                            child: Container(
                              height: 5,
                              width: 32,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                          )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      // todo:replace togglelogin
                      onTap: () {
                        Get.find<RegesterController>().toggleLogin();
                        selectedPageState.value = 2;
                      },

                      child: ImageIcon(
                        Assets.icons.write.provider(),
                        size: 25,
                        color: MySolidColors.scaffoldBack,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    selectedPageState.value == 2
                        ? Opacity(
                            opacity: 1,
                            child: Container(
                              height: 5,
                              width: 32,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                          )
                        : Opacity(
                            opacity: 0.05,
                            child: Container(
                              height: 5,
                              width: 32,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                          )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        switchScreens(1);
                        selectedPageState.value = 1;
                        userController.toggleLogin();
                      },
                      child: ImageIcon(
                        Assets.icons.profile.provider(),
                        size: 25,
                        color: MySolidColors.scaffoldBack,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    selectedPageState.value == 1
                        ? Opacity(
                            opacity: 1,
                            child: Container(
                              height: 5,
                              width: 32,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                          )
                        : Opacity(
                            opacity: 0.05,
                            child: Container(
                              height: 5,
                              width: 32,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
  
  









































