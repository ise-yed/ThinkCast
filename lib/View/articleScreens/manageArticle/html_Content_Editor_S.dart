// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Components/themes/decoration.dart';

import 'package:techblog_project/Controller/article_controller/manageArticle_C.dart';
import 'package:techblog_project/Controller/theme.controller.dart';

class BodyTextEditor extends StatelessWidget {
  BodyTextEditor({super.key});
  final ThemeController themeController = Get.find();

  final HtmlEditorController controller = HtmlEditorController();
  final ManageArticleController manageArticleController =
      Get.put(ManageArticleController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.clearFocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            articleListAppbar(),
            HtmlEditor(
              controller: controller,
              htmlEditorOptions: HtmlEditorOptions(
                  hint: 'edit youe text',
                  initialText:
                      manageArticleController.articleInfoList.value.content!,darkMode: 
                      
                      themeController.isDarkMode.value
                      ,
                  shouldEnsureVisible: true),
              callbacks: Callbacks(
                onChangeContent: (p0) =>
                    manageArticleController.articleInfoList.update((val) {
                  val!.content = p0;
                }),
              ),
            )
          ]),
        ),
      ),
    );
  }

// !ArticleListAppbar
  PreferredSize articleListAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const SizedBox(
            width: 15,
          ),
          Container(
            width: 50,
            height: 50,
            decoration: LightThemeDecorations.listsAppbar,
            child: InkWell(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back,
                color: MySolidColors.scaffoldBack,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                MyStr.writeOrEditAppbatText,
                style: Sizes.theme.headlineSmall,
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          )
        ],
      ),
    );
  }
}
