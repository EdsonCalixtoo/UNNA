import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import '../controllers/postController.dart';
import '../utils/colors.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  AppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.find<CategoryController>();
    PostController postController = Get.find<PostController>();
    return SafeArea(
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(
            "U",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: corBlack,
            ),
          ),
          Text("N", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: corSecundaria)),
          Text("И", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: corPrimaria)),
          Text(
            "A",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: corBlack,
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
