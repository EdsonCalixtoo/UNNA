import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nav_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/colors.dart';

class CustomNavBar extends StatelessWidget {
  final PageController pageController;
  final NavController navController = Get.put(NavController());
  final UserController userController = Get.put(UserController());

  CustomNavBar({super.key, required this.pageController});

  Widget centralButton(NavController nav, Function execute) {
    return GestureDetector(
      onTap: () {
        nav.selectedIndex = -1;
        execute();
      },
      child: Container(
        width: 70,
        height: 45,
        decoration: new BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 35.0,
              offset: Offset(1, 15.75),
            )
          ],
          color: corPrimaria,
          borderRadius: new BorderRadius.all(Radius.circular(40.0)),
        ),
        child: Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }

  Widget iconElement(int index, int indexSelected, IconData icon, Function execute, NavController nav) {
    return GestureDetector(
      onTap: () {
        if (nav.selectedIndex == index) return;

        nav.selectedIndex = index;
        execute();
      },
      child: Icon(icon, color: index != indexSelected ? Colors.black38 : corBlack, size: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: corFundoClara,
        child: Container(
          decoration: new BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black54,
                blurRadius: 35.0,
                offset: Offset(1, 15.75),
              )
            ],
            color: Colors.white,
            borderRadius: new BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
          ),
          height: 80,
          width: double.infinity,
          child: Obx(() => Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconElement(0, navController.selectedIndex, Icons.widgets_outlined, () {
                    pageController.jumpToPage(0);
                  }, navController),
                  // iconElement(1, navController.selectedIndex, Icons.filter_alt, () => pageController.jumpToPage(1),
                  //     navController),
                  centralButton(navController, () {
                    pageController.jumpToPage(1);
                  }),
                  iconElement(3, navController.selectedIndex, Icons.person_outline, () {
                    pageController.jumpToPage(2);
                  }, navController),
                ],
              ))),
        ));
  }
}
