import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/common/appbar_home.dart';
import 'package:unna/controllers/post_controller.dart';
import 'package:unna/controllers/sub_category_controller.dart';
import 'package:unna/models/category.dart';
import 'package:unna/screens/posts.dart';
import 'package:unna/utils/colors.dart';

class SubCategory extends StatefulWidget {
  final String category;

  const SubCategory({
    super.key,
    required this.category,
  });

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  final scrollController = ScrollController();
  PostController postController = Get.find<PostController>();
  SubCategoryController _subCategoryController = Get.find<SubCategoryController>();
  List<CategoryModel> listGeneralCategories = [];
  List<Widget> listIcons = [];
  List<dynamic Function()> actions = [];

  @override
  void initState() {
    super.initState();
    (() async {
      await (() async {
        if (widget.category == 'Pets') {
          listIcons = [
            Icon(
              Icons.emoji_people_outlined,
              size: 40,
            ),
            Icon(
              Icons.style_rounded,
              size: 40,
            ),
            Icon(
              Icons.food_bank_rounded,
              size: 40,
            ),
            Icon(
              Icons.earbuds_battery_rounded,
              size: 40,
            )
          ];

          actions = [
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Pets',
                subCategory: 'Adoção',
              ));
            },
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Pets',
                subCategory: 'Roupas',
              ));
            },
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Pets',
                subCategory: 'Comida',
              ));
            },
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Pets',
                subCategory: 'Acessórios',
              ));
            },
          ];
        } else if (widget.category == 'Esportes') {
          listIcons = [
            Icon(
              Icons.sports_soccer_rounded,
              size: 40,
            ),
            Icon(
              Icons.sports_basketball_rounded,
              size: 40,
            ),
            Icon(
              Icons.sports_volleyball_rounded,
              size: 40,
            ),
            Icon(
              Icons.sports_gymnastics_rounded,
              size: 40,
            ),
            Icon(
              Icons.sports_tennis_rounded,
              size: 40,
            ),
          ];

          actions = [
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Esportes',
                subCategory: 'Futebol',
              ));
            },
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Esportes',
                subCategory: 'Basquete',
              ));
            },
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Esportes',
                subCategory: 'Vôlei',
              ));
            },
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Esportes',
                subCategory: 'Muay thai',
              ));
            },
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Esportes',
                subCategory: 'Muay thai',
              ));
            },
          ];
        } else if (widget.category == 'Lazer') {
          listIcons = [
            Icon(
              Icons.celebration_rounded,
              size: 40,
            ),
            Icon(
              Icons.liquor,
              size: 40,
            ),
            Icon(
              Icons.cake_rounded,
              size: 40,
            ),
            Icon(
              Icons.party_mode_rounded,
              size: 40,
            )
          ];

          actions = [
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Lazer',
                subCategory: 'Shows',
              ));
            },
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Lazer',
                subCategory: 'Festas',
              ));
            },
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Lazer',
                subCategory: 'Festivais',
              ));
            },
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Lazer',
                subCategory: 'Eventos',
              ));
            },
          ];
        } else {
          listIcons = [
            Icon(
              Icons.donut_large,
              size: 40,
            ),
            Icon(
              Icons.domain,
              size: 40,
            ),
          ];

          actions = [
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Voluntariados',
                subCategory: 'Doações',
              ));
            },
            () {
              clearFilter();
              Get.to(Posts(
                category: 'Voluntariados',
                subCategory: 'Ongs',
              ));
            },
          ];
        }
      })();
    })();
    _subCategoryController.getSubCategories(widget.category);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void clearFilter() {
    Get.close(0);
    postController.resetFilters();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: corFundoClara,
      appBar: AppBarHome(isHome: false, isFilter: false),
      extendBody: false,
      extendBodyBehindAppBar: false,
      body: Obx(
        () {
          return ListView.builder(
            itemCount: _subCategoryController.categories.length,
            itemBuilder: (BuildContext context, int index) {
              return TextButton(
                onPressed: actions[index],
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(4),
                  height: 60,
                  width: width,
                  child: Row(
                    children: [
                      listIcons[index],
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        _subCategoryController.categories[index].name,
                        style: TextStyle(
                          fontSize: 18,
                          color: corSilverSoft,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
