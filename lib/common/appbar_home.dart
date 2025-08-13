import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import '../utils/colors.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;
  final bool isFilter;

  const AppBarHome({
    super.key,
    required this.isHome,
    required this.isFilter,
  });

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find<PostController>();

    return SafeArea(
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          !isFilter
              ? SizedBox()
              : IconButton(
                  icon: Icon(
                    Icons.filter_alt_rounded,
                    color: corPrimaria,
                    size: 32,
                  ),
                  onPressed: () {
                    postController.setOptionsFinishVisible(true);
                  },
                  tooltip: 'Filtrar',
                )
        ],
        leading: isHome
            ? SizedBox()
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: corPrimaria,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: 'Voltar',
              ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "U",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: corBlack,
              ),
            ),
            Text(
              "N",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: corSecundaria,
              ),
            ),
            Text(
              "И",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: corPrimaria,
              ),
            ),
            Text(
              "A",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: corBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
