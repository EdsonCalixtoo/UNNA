import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/controllers/nav_controller.dart';
import 'package:unna/controllers/user_controller.dart';
import 'package:unna/utils/colors.dart';

class CustomNavBar extends StatelessWidget {
  final PageController? pageController;
  final NavController navController = Get.put(NavController());
  final UserController userController = Get.put(UserController());

  CustomNavBar({
    super.key,
    required this.pageController,
  });

  Widget centralButton(NavController nav, Function execute) {
    return GestureDetector(
      onTap: () {
        nav.selectedIndex = -1;
        execute();
      },
      child: Container(
        width: 70,
        height: 45,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 35,
              offset: Offset(1, 15.75),
            )
          ],
          color: corPrimaria,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }

  Widget iconElement(
    int index,
    int indexSelected,
    IconData icon,
    String title,
    Function execute,
    NavController nav,
  ) {
    return GestureDetector(
      onTap: () {
        if (nav.selectedIndex == index) return;

        nav.selectedIndex = index;
        execute();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: index != indexSelected ? Colors.black38 : corBlack,
            size: 30,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: index != indexSelected ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: index != indexSelected ? Colors.grey[400] : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 35,
              offset: Offset(1, 15.75),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        height: 100,
        width: double.infinity,
        child: Obx(
          () => Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconElement(
                  0,
                  navController.selectedIndex,
                  Icons.widgets_outlined,
                  'Menu',
                  () {
                    pageController?.jumpToPage(0);
                  },
                  navController,
                ),
                // centralButton(
                //   navController,
                //   () {
                //     pageController?.jumpToPage(1);
                //   },
                // ),
                iconElement(
                  2,
                  navController.selectedIndex,
                  Icons.event,
                  'Eventos',
                  () {
                    pageController?.jumpToPage(1);
                  },
                  navController,
                ),
                iconElement(
                  2,
                  navController.selectedIndex,
                  Icons.email_outlined,
                  'Chat',
                  () {
                    pageController?.jumpToPage(1);
                  },
                  navController,
                ),
                iconElement(
                  3,
                  navController.selectedIndex,
                  Icons.person_outline,
                  'Perfil',
                  () {
                    pageController?.jumpToPage(2);
                  },
                  navController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
