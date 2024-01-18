import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/controllers/category_controller.dart';
import 'package:unna/models/category.dart';
import 'package:unna/models/post.dart';
import 'package:unna/models/story_model.dart';
import 'package:unna/screens/story_page.dart';
import '../common/appbar_home.dart';
import '../controllers/add_new_story_controller.dart';
import '../controllers/postController.dart';
import '../controllers/userController.dart';
import '../services/database.dart';
import '../utils/colors.dart';
import '../widgets/postCard.dart';
import 'add_new_story.dart';

class GeneralCategory extends StatefulWidget {
  @override
  _GeneralCategoryState createState() => _GeneralCategoryState();
}

class _GeneralCategoryState extends State<GeneralCategory> {
  final scrollController = ScrollController();
  PostController postController = Get.find<PostController>();
  CategoryController _categoryController = Get.find<CategoryController>();
  String selectedFilter = 'geral';
  List<CategoryModel> listGeneralCategories = [];

  @override
  void initState() {
    super.initState();
    _categoryController.get();
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
        appBar: AppBarHome(),
        extendBody: false,
        extendBodyBehindAppBar: false,
        body: Obx(() {
          return ListView.builder(
            itemCount: _categoryController.categories.length,
            itemBuilder: (BuildContext context, int index) {
              return TextButton(
                onPressed: () {},
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 60,
                  width: width,
                  child: Text(_categoryController.categories[index].name),
                ),
              );
            },
          );
        }));
  }
}
