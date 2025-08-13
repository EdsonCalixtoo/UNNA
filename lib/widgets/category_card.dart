import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/controllers/nav_controller.dart';
import 'package:unna/controllers/post_controller.dart';
import 'package:unna/models/category.dart';
import 'package:unna/screens/home.dart';
import 'package:unna/utils/colors.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final Function? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          Get.find<PostController>().updateFilter(category.name, '');
          Get.find<NavController>().selectedIndex = 0;
          Get.offAll(
            Home(),
            arguments: category.name,
          );
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: corPrimaria,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.name,
                style: TextStyle(
                  color: corBlack,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Icon(
                IconData(
                  int.parse(category.icon),
                  fontFamily: 'MaterialIcons',
                ),
                size: 65,
              ),
              Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
