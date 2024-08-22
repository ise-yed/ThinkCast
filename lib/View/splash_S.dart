// ignore_for_file: avoid_print, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/gen/assets.gen.dart';
import 'package:techblog_project/Components/routeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  RxBool internetConnectState = false.obs;
  @override
  void initState() {
    super.initState();
    internetConnectionStateFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MySolidColors.scaffoldBack,
        body: SizedBox(
          width: Sizes.size.width,
          height: Sizes.size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              GestureDetector(
                  onTap: () async {
                    print(internetConnectState.value);
                    await internetConnectionStateFunc();
                  },
                  child: SvgPicture.asset(
                    Assets.images.logo.toString(),
                    height: 250,
                    width: Sizes.size.width / 3,
                  )),
              const SizedBox(
                height: 200,
              ),
              const Text(
                'ISE_YED@',
                style: TextStyle(
                    fontSize: 16,
                    // shadows: [
                    //   Shadow(blurRadius: 3, color: MySolidColors.mainColor)
                    // ],
                    letterSpacing: 2),
              )
            ],
          ),
        ));
  }

  Future<bool> internetConnectionStateFunc() async {
    try {
      final result = await InternetAddress.lookup('uptvs.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Get.offAndToNamed(RouteScreens.routeMainScreen);
        return internetConnectState.value = true;
      } else {
        Get.snackbar(
            MyStr.splashInternetTitleText, MyStr.splashInternetbodyText,
            animationDuration: const Duration(seconds: 1),
            forwardAnimationCurve: Curves.linearToEaseOut,
            backgroundColor: MySolidColors.mainColor,
            colorText: MySolidColors.scaffoldBack);
        return internetConnectState.value = false;
      }
    } on SocketException catch (_) {
      Get.snackbar(MyStr.splashInternetTitleText, MyStr.splashInternetbodyText,
          animationDuration: const Duration(seconds: 1),
          forwardAnimationCurve: Curves.linearToEaseOut,
          backgroundColor: MySolidColors.mainColor,
          colorText: MySolidColors.scaffoldBack);
      return internetConnectState.value = false;
    }
  }
}
