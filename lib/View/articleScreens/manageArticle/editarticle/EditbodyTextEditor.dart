// ignore_for_file: prefer_if_null_operators, file_names

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Components/constants/strings.dart';
import 'package:techblog_project/Components/themes/decoration.dart';

import 'package:techblog_project/Controller/article_controller/manageArticle_C.dart';
import 'package:techblog_project/Controller/theme.controller.dart';

class EditbodyTextEditor extends StatelessWidget {

  EditbodyTextEditor({super.key});
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
              htmlEditorOptions: HtmlEditorOptions(darkMode: 
                      
                      themeController.isDarkMode.value,
                  hint: 'edit youe text',
                  initialText: manageArticleController
                              .articleInfoEditList.value.content ==
                          null
                      ? 'enter'
                      : manageArticleController
                          .articleInfoEditList.value.content,
                  shouldEnsureVisible: true),
              callbacks: Callbacks(
                onChangeContent: (p0) =>
                    manageArticleController.articleInfoEditList.update((val) {
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
              onTap: () {Get.back();
              
              debugPrint(manageArticleController.articleInfoEditList.value.content!);
              } ,
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
