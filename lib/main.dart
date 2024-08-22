
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/themes/theme_text_style.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/View/splash_S.dart';
import 'package:techblog_project/binding.dart';
import 'package:techblog_project/Components/routeScreen.dart';

void main() async {
  await GetStorage.init();
  Get.put(ThemeController()); 
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: MySolidColors.scaffoldBack,
    systemNavigationBarDividerColor: MySolidColors.mainColor,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: MySolidColors.scaffoldBack,
  ));
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Obx(() {
      return GetMaterialApp(
        getPages: InMAinRouteScreen.pages,
        initialBinding: RegisterBinding(),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        locale: const Locale('fa'),
        theme: AppTheme.lightTheme,
        darkTheme: DarkModeTheme.darkTheme,
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      );
    });
  }
}
