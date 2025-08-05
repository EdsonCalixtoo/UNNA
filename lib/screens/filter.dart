import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/controllers/post_controller.dart';
import '../controllers/category_controller.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> with SingleTickerProviderStateMixin {
  CategoryController _categoryController = Get.find<CategoryController>();
  PostController _postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: corBlack),
        title: Text(
          "Filtros",
          style: TextStyle(
            color: corBlack,
            fontSize: 35,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: corFundoClara,
        elevation: 0,
        actions: [
          Obx(
            () => _postController.filterLiked.value ||
                    _postController.filterCategory.value != "" ||
                    _postController.filterDate.value != DateTime(1500)
                ? IconButton(
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          title: Text(
                            "Deseja limpar filtros?",
                          ),
                          alignment: Alignment.center,
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: corPrimaria),
                              onPressed: () {
                                Get.close(0);
                              },
                              child: Text(
                                "Sair",
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: corPrimaria),
                              onPressed: () {
                                Get.close(0);
                                _postController.resetFilters();
                              },
                              child: Text(
                                "Limpar",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.filter_alt_off,
                    ),
                  )
                : SizedBox(),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              corFundoClara,
              corFundoEscura,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                ),
                height: MediaQuery.of(context).size.height * 0.80,
                width: double.infinity,
                child: FutureBuilder(
                  future: _categoryController.get('geral'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                        ),
                      );
                    }
                    return filters();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget filters() {
    return Column(
      children: [
        Obx(
          () => CheckboxListTile(
            title: Row(
              children: [
                Icon(
                  CupertinoIcons.heart_fill,
                  size: 40,
                  color: Colors.red,
                ),
                Text(
                  "Por Like:",
                ),
              ],
            ),
            value: _postController.filterLiked.value,
            onChanged: (value) {
              _postController.filterLiked.value = value!;
            },
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                CupertinoIcons.calendar,
                size: 40,
                color: Colors.green,
              ),
              Text(
                "Por data da ação:",
              ),
            ],
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
            onPressed: () {
              Get.dialog(
                DatePickerDialog(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                ),
              ).then((value) {
                if (value != null) {
                  print(value);
                  _postController.filterDate.value = value;
                  _postController.setFilter();
                }
              });
            },
            child: Obx(
              () => Text(
                _postController.filterDate.value == DateTime(1500)
                    ? "Selecione a data"
                    : Utils.dateTimeParseString(date: _postController.filterDate.value, setHours: false),
              ),
            ),
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.category,
                size: 40,
                color: Colors.blue,
              ),
              Text(
                "Por categoria:",
              ),
            ],
          ),
          subtitle: Column(
            children: List.generate(
              _categoryController.categoryList.length,
              (index) => ExpansionTile(
                collapsedIconColor: corPrimaria,
                collapsedTextColor: corPrimaria,
                iconColor: corPrimaria,
                textColor: corPrimaria,
                leading: Icon(
                  IconData(
                    int.parse(
                      _categoryController.categoryList[index].icon,
                    ),
                  ),
                ),
                title: Text(_categoryController.categoryList[index].name),
                children: List.generate(
                  _categoryController.categoryList[index].subCategories.length,
                  (i) => Obx(
                    () => CheckboxListTile(
                      activeColor: corPrimaria,
                      title: Text(
                        _categoryController.categoryList[index].subCategories[i],
                      ),
                      value: _postController.filterCategory.value ==
                          _categoryController.categoryList[index].subCategories[i],
                      onChanged: (value) {
                        if (value!) {
                          _postController.filterCategory.value =
                              _categoryController.categoryList[index].subCategories[i];
                        } else {
                          _postController.filterCategory.value = "";
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
