// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/animatedIconCont.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Controller/regesterController/register_C.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/gen/assets.gen.dart';
import 'package:techblog_project/Components/constants/strings.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final ThemeController themeController = Get.find();
  final registerController = Get.find<RegesterController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.images.happytech.toString(),
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 32,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: MyStr.registerWelcome,
                    style: TextStyle(
                        fontFamily: "dana",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: themeController.isDarkMode.value == false
                            ? const Color.fromRGBO(0, 59, 100, 1)
                            : Colors.white),
                  )),
              const SizedBox(
                height: 64,
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    // ! buttomsheet
                    emailButtomSheet(context,
                        registerController: registerController);
                  },
                  child: const Text(
                    MyStr.letsGo,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'dana',
                      fontWeight: FontWeight.w300,
                      color: MySolidColors.scaffoldBack,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// !EmailButtomSheet
Future<dynamic> emailButtomSheet(BuildContext context,
    {required RegesterController registerController}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: Sizes.size.height / 2,
          decoration: BoxDecoration(
              color: themeController.isDarkMode.value == false
                  ? Colors.white
                  : const Color.fromARGB(255, 1, 10, 24),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
       
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              MyStr.registerEnterEmail,
              style: TextStyle(
                fontFamily: "dana",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: themeController.isDarkMode.value == false
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                //  !validate email
                onChanged: (value) {
                  registerController.emailValidator(value);
                },
                controller: registerController.emailTextEditingController,
                style: Sizes.theme.displayLarge,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: 'seyedmorteza2770@gmail.com'),
              ),
            ),
            // ! validate email Text
            SizedBox(
              child: registerController.isValidEmail.value
                  ? Text(
                      MyStr.validateEmailTrue,
                      style: TextStyle(
                        fontFamily: "dana",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: themeController.isDarkMode.value == false
                            ? Colors.black
                            : Colors.white,
                      ),
                    )
                  : Text(
                      MyStr.validateEmailFalse,
                      style: TextStyle(
                        fontFamily: "dana",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: themeController.isDarkMode.value == false
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
            ),
            const SizedBox(
              height: 32,
            ),
            // ! Next Button
            ElevatedButton(
                onPressed: () {
                  registerController.register();

                  if (registerController.isValidEmail.value) {
                    navigator!.pop(context);
                    verifyButtomSheet(context,
                        registerController: registerController);
                  } else {
                    null;
                  }
                },
                child: const Text(
                  MyStr.registerContinue,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'dana',
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ))
          ]),
        ),
      );
    },
  );
}

// !VerifyButtomSheet
Future<dynamic> verifyButtomSheet(BuildContext context,
    {required RegesterController registerController}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: Sizes.size.height / 2,
          decoration: BoxDecoration(
              color: themeController.isDarkMode.value == false
                  ? Colors.white
                  : const Color.fromARGB(255, 1, 10, 24),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              MyStr.regesterVerificationCodeText,
              style: TextStyle(
                fontFamily: "dana",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: themeController.isDarkMode.value == false
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                controller: registerController.activateEditingController,
                style: Sizes.theme.displayLarge,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: '*****'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  registerController.verify();
                },
                child: const Text(
                  MyStr.registerContinue,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'dana',
                    fontWeight: FontWeight.w300,
                    color: MySolidColors.scaffoldBack,
                  ),
                ))
          ]),
        ),
      );
    },
  );
}
