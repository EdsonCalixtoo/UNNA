import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import '../utils/colors.dart';
import '../widgets/category_card.dart';

class CategoryFilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: corBlack),
        title: Text("Categoria", style: TextStyle(color: corBlack, fontSize: 35, fontWeight: FontWeight.w300)),
        backgroundColor: corFundoClara,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [corFundoClara, corFundoEscura],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15),
                margin: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                ),
                height: MediaQuery.of(context).size.height * 0.80,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 1, left: 16, right: 16),
                  child: activeCourses(showActive: true),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget activeCourses({bool showActive = true}) {
    return GetX<CategoryController>(
      init: Get.put<CategoryController>(CategoryController()),
      builder: (CategoryController? categoryController) {
        if (categoryController?.isLoading.value == true) {
          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(corPrimariaClara)));
        } else {
          if (categoryController != null && categoryController.categoryList.length > 0) {
            return GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 15,
              children: categoryController.categoryList.map((category) {
                return CategoryCard(category: category);
              }).toList(),
            );
          } else {
            return Text("Lista Vazia...");
          }
        }
      },
    );
  }
}
