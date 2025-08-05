// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:unna/models/category.dart';
import 'package:unna/services/database.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/botao_simples.dart';
import '../controllers/category_controller.dart';
import '../utils/colors.dart';

// ignore: must_be_immutable
class CategoryAddEditScreen extends StatefulWidget {
  static String title = 'Gerenciar Categorias';
  static String idEditing = '';

  @override
  State<CategoryAddEditScreen> createState() => _CategoryAddEditScreenState();
}

class _CategoryAddEditScreenState extends State<CategoryAddEditScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController iconTextController = TextEditingController();

  final TextEditingController orderController = TextEditingController();

  var categoryList = <CategoryModel>[].obs;
  var isLoading = false.obs;

  CategoryController _categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    categoryList.value = _categoryController.categoryList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            iconTheme: IconThemeData(color: corBlack),
            title: Text(
              CategoryAddEditScreen.title,
              style: TextStyle(
                color: corBlack,
                fontWeight: FontWeight.w300,
              ),
            ),
            backgroundColor: corFundoClara,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  GlobalKey<FormState> formKey = GlobalKey<FormState>();
                  String categoryName = "";
                  String codepoit = "";
                  Get.dialog(
                    AlertDialog(
                      contentPadding: EdgeInsets.all(5),
                      title: Text(
                        "Adicionar Categoria",
                      ),
                      content: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Digite o nome";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.loyalty,
                                        color: corPrimaria,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: 'Nome',
                                      hintStyle: TextStyle(
                                        color: corPrimariaEscura,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      categoryName = value;
                                    },
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                      color: corBlack,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 70,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Digite o codepoint";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.explore,
                                              color: corPrimaria,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            hintText: 'Icon Codepoint ex: 61103)',
                                            hintStyle: TextStyle(
                                              color: corPrimariaEscura,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            codepoit = value;
                                          },
                                          autocorrect: false,
                                          style: TextStyle(
                                            color: corBlack,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 30,
                                        child: BotaoSimples(
                                          executarAcao: () {
                                            launchUrl(Uri.parse(
                                                'https://api.flutter.dev/flutter/material/Icons-class.html#constants'));
                                          },
                                          iconeBotao: Icon(
                                            Icons.image_search,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          textoBotao: "",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 36),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: corPrimaria),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        Get.close(0);
                                        categoryList.value.add(
                                          CategoryModel(
                                            name: categoryName,
                                            id: "",
                                            icon: codepoit,
                                            order: categoryList.length,
                                            subCategories: [],
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Adicionar",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.add_box),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: corPrimaria),
                  onPressed: () async {
                    try {
                      isLoading.value = true;
                      for (var element in categoryList) {
                        if (element.id == "") {
                          String id = await Database().getReference("unna-categories");
                          await Database().addCategory(element.copyWith(id: id).toMap());
                        } else {
                          await Database().editCategory(element.toMap());
                        }
                      }
                      _categoryController.categoryList = categoryList;
                    } catch (e) {
                      Get.snackbar(
                        'Erro',
                        'Preenche os campos direito que vai!',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: corPrimaria,
                        duration: Duration(seconds: 5),
                        colorText: Colors.white,
                      ).show();
                    }
                    isLoading.value = false;
                  },
                  child: isLoading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(corPrimaria),
                        )
                      : Text(
                          "Salvar Alterações",
                        ),
                ),
              )),
          body: KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [corFundoClara, corFundoEscura],
                  ),
                ),
                child: ListView(
                  children: List.generate(
                    categoryList.length,
                    (index) => ExpansionTile(
                      initiallyExpanded: true,
                      collapsedIconColor: corPrimaria,
                      collapsedTextColor: corPrimaria,
                      iconColor: corPrimaria,
                      textColor: corPrimaria,
                      title: Text(categoryList[index].name),
                      leading: IconButton(
                        onPressed: () {
                          String subCategoryName = "";
                          Get.dialog(
                            AlertDialog(
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: corPrimaria),
                                  onPressed: () {
                                    if (subCategoryName.isEmpty) {
                                      return;
                                    }
                                    List<CategoryModel> categorys = categoryList.value;
                                    categorys[index].subCategories.add(subCategoryName);
                                    categoryList.value = categorys;
                                    Get.close(0);
                                  },
                                  child: Text(
                                    "Adicionar",
                                  ),
                                )
                              ],
                              content: TextFormField(
                                initialValue: subCategoryName,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.loyalty,
                                    color: corPrimaria,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                    borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary),
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: 'Nome',
                                  hintStyle: TextStyle(
                                    color: corPrimariaEscura,
                                  ),
                                ),
                                onChanged: (value) {
                                  subCategoryName = value;
                                },
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  color: corBlack,
                                ),
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add_box,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              GlobalKey<FormState> formKey = GlobalKey<FormState>();
                              String categoryName = categoryList[index].name;
                              String codepoit = categoryList[index].icon;
                              Get.dialog(
                                AlertDialog(
                                  contentPadding: EdgeInsets.all(5),
                                  title: Text(
                                    "Editar Categoria",
                                  ),
                                  content: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                                        ),
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              TextFormField(
                                                initialValue: categoryName,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Digite o nome";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.loyalty,
                                                    color: corPrimaria,
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(90.0),
                                                    ),
                                                    borderSide: BorderSide(
                                                      width: 2,
                                                      color: Theme.of(context).colorScheme.primary,
                                                    ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(90.0),
                                                    ),
                                                    borderSide: BorderSide(
                                                      width: 2,
                                                      color: Theme.of(context).colorScheme.primary,
                                                    ),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.transparent,
                                                  hintText: 'Nome',
                                                  hintStyle: TextStyle(
                                                    color: corPrimariaEscura,
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  categoryName = value;
                                                },
                                                autocorrect: false,
                                                keyboardType: TextInputType.emailAddress,
                                                style: TextStyle(
                                                  color: corBlack,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 70,
                                                    child: TextFormField(
                                                      initialValue: codepoit,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Digite o codepoint";
                                                        }
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                        prefixIcon: Icon(
                                                          Icons.explore,
                                                          color: corPrimaria,
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                                          borderSide: BorderSide(
                                                            width: 2,
                                                            color: Theme.of(context).colorScheme.primary,
                                                          ),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                                          borderSide: BorderSide(
                                                            width: 2,
                                                            color: Theme.of(context).colorScheme.primary,
                                                          ),
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                        hintText: 'Icon Codepoint ex: 61103)',
                                                        hintStyle: TextStyle(
                                                          color: corPrimariaEscura,
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        codepoit = value;
                                                      },
                                                      autocorrect: false,
                                                      style: TextStyle(
                                                        color: corBlack,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 30,
                                                    child: BotaoSimples(
                                                      executarAcao: () {
                                                        launchUrl(Uri.parse(
                                                            'https://api.flutter.dev/flutter/material/Icons-class.html#constants'));
                                                      },
                                                      iconeBotao: Icon(
                                                        Icons.image_search,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                      textoBotao: "",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 36),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(backgroundColor: corPrimaria),
                                                onPressed: () {
                                                  if (formKey.currentState!.validate()) {
                                                    Get.close(0);
                                                    categoryList[index].name = categoryName;
                                                    categoryList[index].icon = codepoit;
                                                    setState(() {});
                                                  }
                                                },
                                                child: Text(
                                                  "Salvar",
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              List<CategoryModel> categorys = categoryList.value;
                              categorys.removeAt(index);
                              categoryList.value = categorys;
                              setState(() {});
                            },
                            icon: Icon(Icons.delete),
                          )
                        ],
                      ),
                      children: List.generate(
                        _categoryController.categoryList[index].subCategories.length,
                        (i) => ListTile(
                          leading: IconButton(
                            onPressed: () {
                              List<CategoryModel> categorys = categoryList.value;
                              categorys[index].subCategories.removeAt(i);
                              categoryList.value = categorys;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              String subCategoryName = categoryList[index].subCategories[i];
                              Get.dialog(AlertDialog(
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: corPrimaria),
                                    onPressed: () {
                                      if (subCategoryName.isEmpty) {
                                        return;
                                      }
                                      List<CategoryModel> categorys = categoryList.value;
                                      categorys[index].subCategories[i] = subCategoryName;
                                      categoryList.value = categorys;
                                      Get.close(0);
                                    },
                                    child: Text(
                                      "Alterar",
                                    ),
                                  )
                                ],
                                content: TextFormField(
                                  initialValue: subCategoryName,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.loyalty,
                                      color: corPrimaria,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hintText: 'Nome',
                                    hintStyle: TextStyle(
                                      color: corPrimariaEscura,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    subCategoryName = value;
                                  },
                                  autocorrect: false,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(color: corBlack),
                                ),
                              ));
                            },
                            icon: Icon(
                              Icons.edit,
                            ),
                          ),
                          title: Text(
                            _categoryController.categoryList[index].subCategories[i],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget areaBotoesInferiores(context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 35,
              child: BotaoSimples(
                executarAcao: () {
                  Get.back();
                },
                iconeBotao: Icon(
                  Icons.cancel,
                  size: 20,
                  color: Colors.white,
                ),
                textoBotao: "Cancelar",
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              flex: 35,
              child: GetX<CategoryController>(
                initState: (_) {},
                builder: (categoryControler) {
                  return !categoryControler.isLoading()
                      ? BotaoSimples(
                          executarAcao: () async {
                            print("\n\n* SALVAR \n");

                            if ((orderController.text.trim() != '') && (iconTextController.text.trim() != '')) {
                              if (_categoryController.isEditing.value) {
                                print('EDIT SALVE: idEditing=' + CategoryAddEditScreen.idEditing);
                                await categoryControler.edit(
                                    CategoryAddEditScreen.idEditing,
                                    nameController.text.trim(),
                                    iconTextController.text.trim(),
                                    int.parse(
                                      orderController.text.trim(),
                                    ));
                              } else {
                                await categoryControler.add(
                                    nameController.text.trim(),
                                    iconTextController.text.trim(),
                                    int.parse(
                                      orderController.text.trim(),
                                    ));
                              }

                              categoryControler.get('geral');
                              Get.back();
                            } else {
                              Get.snackbar(
                                'Opa, ta errado manolo',
                                'Preenche os campos direito que vai!',
                                snackPosition: SnackPosition.TOP,
                                duration: Duration(seconds: 5),
                                colorText: Colors.white,
                              ).show();
                            }
                          },
                          iconeBotao: Icon(
                            Icons.save,
                            size: 20,
                            color: Colors.white,
                          ),
                          textoBotao: "Salvar",
                        )
                      : Container(
                          height: 20,
                          width: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(corPrimariaClara),
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
