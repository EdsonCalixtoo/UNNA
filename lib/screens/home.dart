import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/controllers/category_controller.dart';
import 'package:unna/models/post.dart';
import 'package:unna/models/story_model.dart';
import 'package:unna/screens/posts.dart';
import 'package:unna/screens/sub_category.dart';
import '../common/appbar_home.dart';
import '../controllers/add_new_story_controller.dart';
import '../controllers/post_controller.dart';
import '../controllers/user_controller.dart';
import '../services/database.dart';
import '../utils/colors.dart';
import '../widgets/post_card.dart';
import 'add_new_story.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scrollController = ScrollController();
  PostController postController = Get.find<PostController>();
  CategoryController _categoryController = Get.find<CategoryController>();
  String selectedFilter = 'geral';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserController _userController = Get.find<UserController>();
    final double heightMarginTop = MediaQuery.of(context).padding.top;
    final double heightMarginBottom = MediaQuery.of(context).padding.bottom;
    final double appBarHeight = AppBar().preferredSize.height;
    final double height =
        MediaQuery.of(context).size.height - appBarHeight - heightMarginTop - heightMarginBottom - kToolbarHeight;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: corFundoClara,
        appBar: AppBarHome(isHome: true, isFilter: false),
        extendBody: false,
        extendBodyBehindAppBar: false,
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 14),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: (width * 0.5) - 22,
                    width: (width * 0.5) - 22,
                    decoration:
                        BoxDecoration(color: corWhite, borderRadius: BorderRadius.circular(20), boxShadow: const [
                      BoxShadow(
                        color: corShadows,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 0),
                      )
                    ]),
                    child: TextButton(
                        onPressed: () {
                          Get.to(Posts(category: 'geral'));
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          fixedSize: Size((width * 0.5) - 22, (width * 0.5) - 22),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Center(
                            child: SizedBox(
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.fitbit_rounded, size: 50, color: corSilverSoft),
                              Text(
                                'Geral',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: corSilverSoft),
                              )
                            ],
                          ),
                        ))),
                  ),
                  Container(
                    height: (width * 0.5) - 22,
                    width: (width * 0.5) - 22,
                    decoration:
                        BoxDecoration(color: corWhite, borderRadius: BorderRadius.circular(20), boxShadow: const [
                      BoxShadow(
                        color: corShadows,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 0),
                      )
                    ]),
                    child: TextButton(
                        onPressed: () {
                          Get.to(SubCategory(
                            category: 'Pets',
                          ));
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          fixedSize: Size((width * 0.5) - 22, (width * 0.5) - 22),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Center(
                            child: SizedBox(
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.pets_rounded, size: 50, color: corSilverSoft),
                              Text(
                                'Pets',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: corSilverSoft),
                              )
                            ],
                          ),
                        ))),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: (width * 0.5) - 22,
                    width: (width * 0.5) - 22,
                    decoration:
                        BoxDecoration(color: corWhite, borderRadius: BorderRadius.circular(20), boxShadow: const [
                      BoxShadow(
                        color: corShadows,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 0),
                      )
                    ]),
                    child: TextButton(
                        onPressed: () {
                          Get.to(SubCategory(
                            category: 'Esportes',
                          ));
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          fixedSize: Size((width * 0.5) - 22, (width * 0.5) - 22),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Center(
                            child: SizedBox(
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.sports_handball_rounded, size: 50, color: corSilverSoft),
                              Text(
                                'Esportes',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: corSilverSoft),
                              )
                            ],
                          ),
                        ))),
                  ),
                  Container(
                    height: (width * 0.5) - 22,
                    width: (width * 0.5) - 22,
                    decoration:
                        BoxDecoration(color: corWhite, borderRadius: BorderRadius.circular(20), boxShadow: const [
                      BoxShadow(
                        color: corShadows,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 0),
                      )
                    ]),
                    child: TextButton(
                        onPressed: () {
                          Get.to(SubCategory(
                            category: 'Lazer',
                          ));
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          fixedSize: Size((width * 0.5) - 22, (width * 0.5) - 22),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Center(
                            child: SizedBox(
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.park_rounded, size: 50, color: corSilverSoft),
                              Text(
                                'Lazer',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: corSilverSoft),
                              )
                            ],
                          ),
                        ))),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: (width * 0.5) - 22,
                    width: (width * 0.5) - 22,
                    decoration:
                        BoxDecoration(color: corWhite, borderRadius: BorderRadius.circular(20), boxShadow: const [
                      BoxShadow(
                        color: corShadows,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 0),
                      )
                    ]),
                    child: TextButton(
                        onPressed: () {
                          Get.to(SubCategory(
                            category: 'Voluntariados',
                          ));
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          fixedSize: Size((width * 0.5) - 22, (width * 0.5) - 22),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Center(
                            child: SizedBox(
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.hail_rounded, size: 50, color: corSilverSoft),
                              Text(
                                'Voluntariados',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: corSilverSoft),
                              )
                            ],
                          ),
                        ))),
                  ),
                ],
              ),
            ),
          ]),
        )));
  }
}
