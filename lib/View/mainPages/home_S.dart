// ignore_for_file: file_names, unrelated_type_equality_checks

// import 'package:animated_icon/animate_icon.dart';

import 'package:animated_icon/animated_icon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:techblog_project/Components/constants/Sizes.dart';
import 'package:techblog_project/Components/routeScreen.dart';
import 'package:techblog_project/Components/themes/decoration.dart';
import 'package:techblog_project/Controller/article_controller/articleInfo_C.dart';
import 'package:techblog_project/Controller/article_controller/articleList_S_C.dart';
import 'package:techblog_project/Controller/homeScreenController/homeScreen_C.dart';
import 'package:techblog_project/Components/comp.dart';
import 'package:techblog_project/Components/constants/colors.dart';
import 'package:techblog_project/Controller/theme.controller.dart';
import 'package:techblog_project/gen/assets.gen.dart';
import 'package:techblog_project/Components/constants/strings.dart';

import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });
  final homeScreenController = Get.find<HomeScreenController>();
  final themeController = Get.find<ThemeController>();
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0)).then((value) {
      homeScreenController.getHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        displacement: 5,
        edgeOffset: 0,
        strokeWidth: 3,
        backgroundColor: MySolidColors.mainColor,
        color: Colors.white,
        onRefresh: _refresh,
        child:
            //  Container(color: Colors.blue,height: 150,width: 100,
            // child:
            // ListView.builder(itemCount: 2,itemBuilder: (context, index) {
            //   Container(color: Colors.white,width: 5,height: 5,);
            // },),
            // )

            Scaffold(
          body: SingleChildScrollView(
            child: Obx(
              () {
                return homeScreenController.homeScreenLoading.isFalse
                    ? Stack(
                        children: [
                          Column(
                            children: [
                              // ! Poster
                              Center(
                                child: CarouselSlider(
                                  items: [poster1(), poster2(), poster3()],
                                  options: CarouselOptions(
                                    initialPage: 0,
                                    enlargeFactor: 2,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.height,
                                    scrollDirection: Axis.horizontal,
                                    enableInfiniteScroll: true,
                                    viewportFraction: 1,
                                    enlargeCenterPage: true,
                                    animateToClosest: true,
                                    autoPlay: true,
                                    height: 200,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.slowMiddle,
                                    pauseAutoPlayOnTouch: true,
                                    onPageChanged: (index, reason) {
                                      switch (index) {
                                        case 0:
                                          homeScreenController
                                              .posterState.value = index;

                                          break;
                                        case 1:
                                          homeScreenController
                                              .posterState.value = index;

                                          break;
                                        case 2:
                                          homeScreenController
                                              .posterState.value = index;

                                          break;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              // poster(),
                              const SizedBox(
                                height: 2,
                              ),
                              // ! poster State
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  homeScreenController.posterState.value == 0
                                      ? Icon(
                                          Icons.article_rounded,
                                          color: themeController.isDarkMode ==
                                                  false
                                              ? Colors.black
                                              : Colors.white,
                                        )
                                      : Icon(Icons.article_outlined,
                                          color: themeController.isDarkMode ==
                                                  false
                                              ? Colors.black
                                              : Colors.white),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  homeScreenController.posterState.value == 1
                                      ? Icon(Icons.my_library_music_rounded,
                                          color: themeController.isDarkMode ==
                                                  false
                                              ? Colors.black
                                              : Colors.white)
                                      : Icon(Icons.my_library_music_outlined,
                                          color: themeController.isDarkMode ==
                                                  false
                                              ? Colors.black
                                              : Colors.white),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  homeScreenController.posterState.value == 2
                                      ? Icon(Icons.article_rounded,
                                          color: themeController.isDarkMode ==
                                                  false
                                              ? Colors.black
                                              : Colors.white)
                                      : Icon(Icons.article_outlined,
                                          color: themeController.isDarkMode ==
                                                  false
                                              ? Colors.black
                                              : Colors.white)
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              // ! TagsList
                        
                              tags(),
                              //! titleArticle
                              titleArticle(),
                              const SizedBox(
                                height: 2,
                              ),
                              // ! articleContainer
                              articleContainer(),

                              //! titlePodcast
                              titlePodcast(),

                              // ! PodcastContainer
                              podcastContainer(),
                              const SizedBox(
                                height: 80,
                              )
                            ],
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                                height: Sizes.size.height,
                                width: Sizes.widthsize,
                                decoration: BoxDecoration(
                                    gradient:
                                        themeController.isDarkMode.value ==
                                                false
                                            ? const LinearGradient(
                                                colors: [
                                                    Color.fromARGB(
                                                        0, 255, 255, 255),
                                                    Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  ],
                                                begin: Alignment.topRight,
                                                end: Alignment.topLeft)
                                            : const LinearGradient(colors: [
                                                Color.fromARGB(0, 0, 0, 0),
                                                Color.fromARGB(255, 1, 10, 24),
                                                Color.fromARGB(255, 1, 10, 24),
                                              ]))),
                          ),
                          Positioned(
                            left: 0,
                            child: Container(
                              height: Sizes.size.height,
                              width: 10,
                              decoration: BoxDecoration(
                                  gradient: themeController.isDarkMode.value ==
                                          false
                                      ? const LinearGradient(
                                          colors: [
                                              Color.fromARGB(0, 255, 255, 255),
                                              Color.fromARGB(
                                                  255, 255, 255, 255),
                                              Color.fromARGB(
                                                  255, 255, 255, 255),
                                              Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ],
                                          begin: Alignment.topRight,
                                          end: Alignment.topLeft)
                                      : const LinearGradient(colors: [
                                          Color.fromARGB(255, 1, 10, 24),
                                          Color.fromARGB(255, 1, 10, 24),
                                          Color.fromARGB(0, 0, 0, 0),
                                        ])),
                            ),
                          )
                        ],
                      )
                    // ! while data not get
                    : loader();
              },
            ),
          ),
        ));
  }



//! titlePodcast
  GestureDetector titlePodcast() {
    return GestureDetector(
      onTap: () => Get.toNamed(RouteScreens.routePodcastListScreen),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, Sizes.widthsize, 0),
        child: Container(
          color: Colors.transparent,
          height: Sizes.widthsize * 3.30,
          child: Row(
            children: [
              AnimateIcon(
                key: UniqueKey(),
                onTap: () {
                  Get.toNamed(RouteScreens.routePodcastListScreen);
                },
                iconType: IconType.continueAnimation,
                width: 20,
                color: MySolidColors.blueTitle,
                animateIcon: AnimateIcons.activity,
                toolTip: 'صفحه مقالات',
              ),
              const SizedBox(
                width: 5,
              ),
              Text(MyStr.hotestPodcast,
                  style: TextStyle(
                      fontFamily: "dana",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: themeController.isDarkMode.value == false
                          ? const Color.fromRGBO(40, 107, 184, 1)
                          : const Color.fromRGBO(0, 221, 249, 1))),
            ],
          ),
        ),
      ),
    );
  }

// !titleArticle
  GestureDetector titleArticle() {
    return GestureDetector(
      onTap: () {
        Get.find<ArticleListController>().getArticleHighListData();
        Get.find<ArticleListController>().appBarText.value =
            MyStr.minArticleListAppbarText;

        Get.toNamed(RouteScreens.routeArticleListScreen);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, Sizes.widthsize, 0),
        child: Container(
          height: Sizes.widthsize * 3.30,
          color: Colors.transparent,
          child: Row(
            children: [
              AnimateIcon(
                key: UniqueKey(),
                onTap: () {
                  Get.find<ArticleListController>().getArticleHighListData();
                  Get.find<ArticleListController>().appBarText.value =
                      MyStr.minArticleListAppbarText;

                  Get.toNamed(RouteScreens.routeArticleListScreen);
                },
                iconType: IconType.continueAnimation,
                width: 20,
                color: MySolidColors.blueTitle,
                animateIcon: AnimateIcons.edit,
                toolTip: 'صفحه مقالات',
              ),
              // Image(
              //   image: Assets.icons.moretext.provider(),
              //   height: 20,
              // ),

              Text(MyStr.hotestText,
                  style: TextStyle(
                      fontFamily: "dana",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: themeController.isDarkMode.value == false
                          ? const Color.fromRGBO(40, 107, 184, 1)
                          : const Color.fromRGBO(0, 221, 249, 1))),
            ],
          ),
        ),
      ),
    );
  }

// ! articleContainer
  Widget articleContainer() {
    return SizedBox(
      height: Sizes.size.height / 4.6,
      child: ListView.builder(
        // physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeScreenController.topVisited.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.find<ArticleInfoController>()
                  .getArticleInfo(homeScreenController.topVisited[index].id!);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, index == 0 ? Sizes.widthsize : 16, 0),
              child: SizedBox(
                width: 125,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Stack(children: [
                      CachedNetworkImage(
                        errorWidget: (context, url, error) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  color: Color.fromARGB(210, 0, 25, 50),
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            // foregroundDecoration: LightThemeDecorations.apFront,
                            child: SvgPicture.asset(
                              Assets.images.logo.toString(),
                              height: 120,
                              width: 120,
                            ),
                          );
                        },
                        placeholder: (context, url) {
                          return loadingSpinKit();
                        },
                        imageUrl: homeScreenController.topVisited[index].image!,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 120,
                            width: 125,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: Color.fromARGB(210, 0, 25, 50),
                                  )
                                ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                image: DecorationImage(
                                    fit: BoxFit.cover, image: imageProvider)),
                            foregroundDecoration: LightThemeDecorations.apFront,
                          );
                        },
                      ),
                      Positioned(
                          bottom: 5,
                          left: 5,
                          right: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                homeScreenController.topVisited[index].author!,
                                style: Sizes.theme.displaySmall,
                              ),
                              Text(
                                "like ${homeScreenController.topVisited[index].view}",
                                style: Sizes.theme.displaySmall,
                              )
                            ],
                          ))
                    ]),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(homeScreenController.topVisited[index].title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: "dana",
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: themeController.isDarkMode.value == false
                                ? Colors.black
                                : Colors.white))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

// !Tags section
  Widget tags() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeScreenController.tagsList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.find<ArticleListController>().getArticleListWithTagsId(
                  homeScreenController.tagsList[index].id!);
              Get.find<ArticleListController>().appBarText.value =
                  homeScreenController.tagsList[index].title!;
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  10, 0, index == 0 ? Sizes.widthsize : 0, 0),
              child: Container(
                decoration: LightThemeDecorations.homeScreenTags,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: Assets.icons.hashtag.provider(),
                        height: 20,
                        color: MySolidColors.hashtagIconColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        Get.find<HomeScreenController>().tagsList[index].title!,
                        style: Sizes.theme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

// !PodcastContainer
  Widget podcastContainer() {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeScreenController.topPodcasts.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed(RouteScreens.routePodcastItemScreen,
                  arguments: homeScreenController.topPodcasts[index]);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, index == 0 ? Sizes.widthsize : 16, 0),
              child: SizedBox(
                width: 125,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    CachedNetworkImage(
                      errorWidget: (context, url, error) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Color.fromARGB(210, 0, 25, 50),
                              )
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          // foregroundDecoration: LightThemeDecorations.apFront,
                          child: SvgPicture.asset(
                            Assets.images.logo.toString(),
                            height: 120,
                            width: 120,
                          ),
                        );
                      },
                      placeholder: (context, url) {
                        return loadingSpinKit();
                      },
                      imageUrl: homeScreenController.topPodcasts[index].poster!,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 2,
                                  color: Color.fromARGB(210, 0, 25, 50),
                                )
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  // todo:wrong code image from article not
                                  image: imageProvider)),
                          foregroundDecoration: LightThemeDecorations.apFront,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      homeScreenController.topPodcasts[index].title!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "dana",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: themeController.isDarkMode.value == false
                              ? Colors.black
                              : Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

// !  poster
//   Widget poster() {
//     return InkWell(
//       onTap: () {
//         Get.find<ArticleInfoController>()
//             .getArticleInfo(homeScreenController.posterData!.value.id!);
//       },
//       child: Stack(children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//           child: CachedNetworkImage(
//             fit: BoxFit.cover,
//             errorWidget: (context, url, error) {
//               return const Icon(Icons.image_not_supported_rounded, size: 50);
//             },
//             placeholder: (context, url) {
//               return loadingSpinKit();
//             },
//             imageUrl: homeScreenController.posterData!.value.image.toString(),
//             imageBuilder: (context, imageProvider) {
//               return Container(
//                 width: Sizes.size.width / 1.15,
//                 height: Sizes.size.height / 4.20,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     image: DecorationImage(
//                         fit: BoxFit.cover, image: imageProvider)),
//                 foregroundDecoration:
//                     LightThemeDecorations.homeScreenPosterFront,
//               );
//             },
//           ),
//         ),
//         Positioned(
//           bottom: 20,
//           right: 5,
//           left: 5,
//           child: Column(
//             children: [
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   // Text(
//                   //   "${homeScreenController.posterData.value.[0].writer} - ${information[0].publishDate}",
//                   //   style: Sizes.theme.displaySmall,
//                   // ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(children: [
//                     // Text(
//                     //   information[0].view.toString(),
//                     //   style: Sizes.theme.displaySmall,
//                     // ),
//                     SizedBox(
//                       width: 2,
//                     ),
//                     Icon(
//                       Icons.remove_red_eye_rounded,
//                       size: 20,
//                       color: MySolidColors.scaffoldBack,
//                     )
//                   ])
//                 ],
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 homeScreenController.posterData!.value.title.toString(),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: Sizes.theme.headlineMedium,
//               )
//             ],
//           ),
//         )
//       ]),
//     );
//   }

// !  poster1
  Widget poster1() {
    return InkWell(
      onTap: () {
        Get.find<ArticleInfoController>()
            .getArticleInfo(homeScreenController.topVisited[0].id!);
      },
      child: Center(
        child: Stack(children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return const Icon(Icons.image_not_supported_rounded, size: 50);
            },
            placeholder: (context, url) {
              return loadingSpinKit();
            },
            imageUrl: homeScreenController.topVisited[0].image!,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: Sizes.size.width / 1.12,
                height: Sizes.size.height / 4.20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: imageProvider)),
                foregroundDecoration:
                    LightThemeDecorations.homeScreenPosterFront,
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 5,
            left: 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${homeScreenController.topVisited[0].author!} - ${homeScreenController.topVisited[0].createdAt}",
                      style: Sizes.theme.displaySmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(children: [
                      Text(
                        homeScreenController.topVisited[0].view!,
                        style: Sizes.theme.displaySmall,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.remove_red_eye_rounded,
                        size: 20,
                        color: MySolidColors.scaffoldBack,
                      )
                    ])
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  homeScreenController.topVisited[0].title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Sizes.theme.headlineMedium,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

// !  poster2
  Widget poster2() {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteScreens.routePodcastItemScreen,
            arguments: homeScreenController.topPodcasts[1]);
      },
      child: Center(
        child: Stack(children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return const Icon(Icons.image_not_supported_rounded, size: 50);
            },
            placeholder: (context, url) {
              return loadingSpinKit();
            },
            imageUrl: homeScreenController.topPodcasts[1].poster!,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: Sizes.size.width / 1.12,
                height: Sizes.size.height / 4.20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: imageProvider)),
                foregroundDecoration:
                    LightThemeDecorations.homeScreenPosterFront,
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 5,
            left: 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${homeScreenController.topPodcasts[1].author!}- ${homeScreenController.topPodcasts[1].createdAt!}",
                      style: Sizes.theme.displaySmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(children: [
                      Text(
                        homeScreenController.topPodcasts[1].view!,
                        style: Sizes.theme.displaySmall,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.remove_red_eye_rounded,
                        size: 20,
                        color: MySolidColors.scaffoldBack,
                      )
                    ])
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      homeScreenController.topPodcasts[1].title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Sizes.theme.headlineMedium,
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

// !  poster3
  Widget poster3() {
    return InkWell(
      onTap: () {
        Get.find<ArticleInfoController>()
            .getArticleInfo(homeScreenController.topVisited[4].id!);
      },
      child: Center(
        child: Stack(children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return const Icon(Icons.image_not_supported_rounded, size: 50);
            },
            placeholder: (context, url) {
              return loadingSpinKit();
            },
            imageUrl: homeScreenController.topVisited[4].image!,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: Sizes.size.width / 1.12,
                height: Sizes.size.height / 4.20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: imageProvider)),
                foregroundDecoration:
                    LightThemeDecorations.homeScreenPosterFront,
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 5,
            left: 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${homeScreenController.topVisited[4].author!} - ${homeScreenController.topVisited[4].createdAt}",
                      style: Sizes.theme.displaySmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(children: [
                      Text(
                        homeScreenController.topVisited[4].view!,
                        style: Sizes.theme.displaySmall,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.remove_red_eye_rounded,
                        size: 20,
                        color: MySolidColors.scaffoldBack,
                      )
                    ])
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  homeScreenController.topVisited[4].title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Sizes.theme.headlineMedium,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
