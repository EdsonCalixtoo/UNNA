import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import '../common/botao_simples.dart';
import '../controllers/category_controller.dart';
import '../controllers/post_controller.dart';
import '../controllers/user_controller.dart';
import '../models/post.dart';
import '../services/database.dart';
import '../utils/colors.dart';

// ignore: must_be_immutable
class PostAddEditScreen extends StatelessWidget {
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController categoryTextController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  static String title = 'Adicionar Categoria';
  static String idEditing = '';

  PostController _postController = Get.find<PostController>();

  var isGalery = true.obs;
  var categorySelected = 'geral'.obs;
  var subcategorySelected = ''.obs;
  var imageTempUrl = File("").obs;
  var isLoading = false.obs;
  var selectedDate = DateTime.now().obs;

  final categorias = ['geral'];
  final subCategorias = [].obs;

  CategoryController _categoryController = Get.find<CategoryController>();
  UserController _userController = Get.find<UserController>();
  late PostModel model;
  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      imageTempUrl = File("").obs;
      print('\n\n\n -----------------');
      print(Get.arguments);
      model = Get.arguments as PostModel;
      idEditing = model.id!;
      bodyController.text = model.body!;
      categorySelected.value = model.category!;
      if (model.category != "geral") {
        for (var i = 0; i < _categoryController.categoryList.length; i++) {
          if (model.category == _categoryController.categoryList[i].name) {
            subCategorias.value = _categoryController.categoryList[i].subCategories;
            for (var element in _categoryController.categoryList[i].subCategories) {
              if (element == model.subCategorie) {
                subcategorySelected.value = model.subCategorie!;
              }
            }
            if (subcategorySelected.value == "") {
              subcategorySelected.value = _categoryController.categoryList[i].subCategories.first;
            }
          }
        }
      }
      title = 'Editar Postagem';
      selectedDate.value = model.actionData?.toDate() ?? DateTime.now();
      _postController.isEditing.value = true;
      _postController.imageTempUrl.value = model.postImage!;
    } else {
      title = 'Nova Postagem';
      idEditing = '';
      _postController.isEditing.value = false;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
            return SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Container(
                  width: constraints.maxWidth,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20),
                  color: corFundoClara,
                  child: Container(
                    width: constraints.maxWidth * 0.95,
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight * 0.9,
                    ),
                    padding: EdgeInsets.all(10),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                              color: corBlack, fontSize: constraints.maxWidth * 0.06, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey.shade300,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  isGalery.value = true;
                                },
                                child: Obx(() => Container(
                                      width: constraints.maxWidth * 0.37,
                                      height: constraints.maxHeight * 0.06,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: isGalery.value ? Colors.grey : Colors.grey.shade300,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Galeria",
                                        style: TextStyle(
                                          fontSize: constraints.maxWidth * 0.05,
                                        ),
                                      )),
                                    )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  isGalery.value = false;
                                },
                                child: Obx(() => Container(
                                      width: constraints.maxWidth * 0.37,
                                      height: constraints.maxHeight * 0.06,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: isGalery.value ? Colors.grey.shade300 : Colors.grey,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Câmera",
                                        style: TextStyle(
                                          fontSize: constraints.maxWidth * 0.05,
                                        ),
                                      )),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Obx(() => imageTempUrl.value.path != ''
                            ? GestureDetector(
                                onTap: () async {
                                  imageTempUrl.value = File("");
                                  if (isGalery.value) {
                                    final ImagePicker picker = ImagePicker();
                                    XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                    if (image != null) {
                                      imageSelected(File(image.path));
                                    }
                                  } else {
                                    final ImagePicker picker = ImagePicker();
                                    XFile? image = await picker.pickImage(source: ImageSource.camera);

                                    if (image == null) return;

                                    imageSelected(File(image.path));
                                  }
                                },
                                child: Container(
                                  height: constraints.maxHeight / 2.3,
                                  width: constraints.maxWidth * 0.85,
                                  decoration: new BoxDecoration(
                                      color: Colors.white, borderRadius: new BorderRadius.all(Radius.circular(10.0))),
                                  child: ClipRRect(
                                    borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                                    child: Image.file(
                                      imageTempUrl.value,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : _postController.isEditing.value
                                ? GestureDetector(
                                    onTap: () async {
                                      if (isGalery.value) {
                                        final ImagePicker picker = ImagePicker();
                                        XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                        if (image != null) {
                                          imageSelected(File(image.path));
                                        }
                                      } else {
                                        final ImagePicker picker = ImagePicker();
                                        XFile? image = await picker.pickImage(source: ImageSource.camera);

                                        if (image == null) return;

                                        imageSelected(File(image.path));
                                      }
                                    },
                                    child: Container(
                                      height: constraints.maxHeight / 2.3,
                                      width: constraints.maxWidth * 0.85,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: new BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: new BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: model.postImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      if (isGalery.value) {
                                        final ImagePicker picker = ImagePicker();
                                        XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                        if (image != null) {
                                          imageSelected(File(image.path));
                                        }
                                      } else {
                                        final ImagePicker picker = ImagePicker();
                                        XFile? image = await picker.pickImage(source: ImageSource.camera);

                                        if (image == null) return;

                                        imageSelected(File(image.path));
                                      }
                                    },
                                    child: Container(
                                      height: constraints.maxHeight / 2.3,
                                      width: constraints.maxWidth * 0.85,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: new BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.photo_size_select_actual,
                                              color: Colors.white,
                                              size: constraints.maxWidth * 0.3,
                                            ),
                                            Text(
                                              "Defina Imagem",
                                              style: TextStyle(
                                                  fontSize: constraints.maxWidth * 0.05,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                          ]),
                                    ),
                                  )),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.85,
                          child: TextFormField(
                            cursorColor: corPrimaria,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(width: 2, color: corPrimaria),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(width: 2, color: corPrimaria)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                    borderSide: BorderSide(width: 2, color: corPrimaria)),
                                filled: true,
                                fillColor: Colors.transparent,
                                label: Text('Texto...'),
                                alignLabelWithHint: true,
                                labelStyle: TextStyle(color: corPrimariaEscura)),
                            controller: bodyController,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null) {
                                return "Texto Invalido";
                              }
                              if (value.isEmpty) {
                                return "O texto não pode ser vazio";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(color: corPrimaria),
                            maxLines: 4,
                          ),
                        ),
                        SizedBox(height: 16),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: corPrimaria, width: 2),
                              ),
                              height: 250,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Obx(() => ScrollDatePicker(
                                      selectedDate: selectedDate.value,
                                      maximumDate: DateTime.now().add(Duration(days: 360)),
                                      locale: Locale('pt'),
                                      options: DatePickerOptions(),
                                      viewType: [
                                        DatePickerViewType.day,
                                        DatePickerViewType.month,
                                        DatePickerViewType.year
                                      ],
                                      onDateTimeChanged: (DateTime value) {
                                        selectedDate.value = value;
                                      },
                                    )),
                              ),
                            ),
                            Positioned(
                              top: -8,
                              left: 20,
                              child: Container(
                                color: Colors.white,
                                child: Text(
                                  " Data da ação ",
                                  style: TextStyle(color: corPrimaria),
                                ),
                              ),
                            ),
                            Obx(() => (selectedDate.value
                                        .difference(
                                            DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))
                                        .inDays !=
                                    0)
                                ? Positioned(
                                    top: -8,
                                    right: 20,
                                    child: Container(
                                      color: Colors.white,
                                      child: GestureDetector(
                                        onTap: () {
                                          selectedDate.value = DateTime.now();
                                        },
                                        child: Text(
                                          " voltar para hoje ",
                                          style: TextStyle(color: corPrimaria),
                                        ),
                                      ),
                                    ))
                                : SizedBox())
                          ],
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: constraints.maxWidth * 0.85,
                          child: Obx(() => DropdownButtonFormField<String>(
                                style: TextStyle(color: corPrimaria, fontSize: constraints.maxWidth * 0.05),
                                decoration: InputDecoration(
                                    label: Text(
                                      "Selecione a Categoria",
                                      style: TextStyle(
                                        color: corPrimaria,
                                        fontSize: constraints.maxWidth * 0.04,
                                      ),
                                    ),
                                    iconColor: corPrimaria,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                      borderSide: BorderSide(width: 2, color: corPrimaria),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                        borderSide: BorderSide(width: 2, color: corPrimaria)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                        borderSide: BorderSide(width: 2, color: corPrimaria))),
                                value: categorySelected.value,
                                onChanged: (value) {
                                  categorySelected.value = value ?? "geral";
                                  subCategorias.value = [];
                                  subcategorySelected.value = "";
                                  if (value != "geral") {
                                    for (var element in _categoryController.categoryList) {
                                      if (element.name == value) {
                                        subcategorySelected.value = element.subCategories.first;
                                        subCategorias.value = element.subCategories;
                                      }
                                    }
                                  }
                                },
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'geral',
                                    child: Text('geral'),
                                  ),
                                  ...List.generate(
                                      _categoryController.categoryList.length,
                                      (i) => DropdownMenuItem<String>(
                                            value: _categoryController.categoryList[i].name,
                                            child: Text(_categoryController.categoryList[i].name),
                                          ))
                                ],
                              )),
                        ),
                        SizedBox(height: 10),
                        // ignore: invalid_use_of_protected_member
                        Obx(() => subCategorias.value.isNotEmpty
                            ? SizedBox(
                                width: constraints.maxWidth * 0.85,
                                child: Obx(() => DropdownButtonFormField<String>(
                                      style: TextStyle(color: corPrimaria, fontSize: constraints.maxWidth * 0.05),
                                      decoration: InputDecoration(
                                          label: Text(
                                            "Selecione a Sub-Categoria",
                                            style: TextStyle(
                                              color: corPrimaria,
                                              fontSize: constraints.maxWidth * 0.04,
                                            ),
                                          ),
                                          iconColor: corPrimaria,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                            borderSide: BorderSide(width: 2, color: corPrimaria),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                              borderSide: BorderSide(width: 2, color: corPrimaria)),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                              borderSide: BorderSide(width: 2, color: corPrimaria))),
                                      value: subcategorySelected.value,
                                      onChanged: (value) {
                                        subcategorySelected.value = value ?? "geral";
                                      },
                                      items: [
                                        ...List.generate(
                                          subCategorias.length,
                                          (i) => DropdownMenuItem<String>(
                                            value: subCategorias[i],
                                            child: Text(subCategorias[i]),
                                          ),
                                        )
                                      ],
                                    )),
                              )
                            : SizedBox()),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                if (Get.arguments != null)
                                  Expanded(
                                    flex: 35,
                                    child: BotaoSimples(
                                      executarAcao: () {
                                        Get.back();
                                      },
                                      iconeBotao: Icon(Icons.cancel, size: 20, color: Colors.white),
                                      textoBotao: "Cancelar",
                                    ),
                                  ),
                                if (Get.arguments != null)
                                  SizedBox(
                                    width: 10,
                                  ),
                                Expanded(
                                  flex: 35,
                                  child: Obx(
                                    () => !isLoading.value
                                        ? BotaoSimples(
                                            executarAcao: () async {
                                              isLoading.value = true;
                                              if (_postController.isEditing.value == false) {
                                                if (imageTempUrl.value.path == "") {
                                                  Get.snackbar('Erro!', 'Adicione uma imagem!',
                                                          snackPosition: SnackPosition.TOP,
                                                          duration: Duration(seconds: 5),
                                                          colorText: Colors.white,
                                                          backgroundColor: corPrimaria)
                                                      .show();
                                                  isLoading.value = false;
                                                  return;
                                                }
                                              } else {
                                                if (imageTempUrl.value.path != "") {
                                                  Database().deleteMedia(path: model.postImage!);
                                                  _postController.imageTempUrl.value =
                                                      await Database().uploadPictureGetUrl(imageTempUrl.value);
                                                }
                                              }
                                              if (formkey.currentState!.validate()) {
                                                try {
                                                  if (_postController.isEditing.value) {
                                                    await _postController.edit(
                                                        id: idEditing,
                                                        body: bodyController.text.trim(),
                                                        category: categorySelected.value.trim(),
                                                        userHandle: _userController.user.email!,
                                                        userName: _userController.user.name!,
                                                        userImage: _userController.user.userImage!,
                                                        postImage: _postController.imageTempUrl.value,
                                                        actionData: selectedDate.value,
                                                        subCategorie: subcategorySelected.value);
                                                    Get.snackbar(
                                                      'Sucesso!',
                                                      'Atualização concluida!',
                                                      snackPosition: SnackPosition.TOP,
                                                      duration: Duration(seconds: 5),
                                                      colorText: Colors.white,
                                                    ).show();
                                                    Get.close(0);
                                                  } else {
                                                    if (imageTempUrl.value.path != "") {
                                                      _postController.imageTempUrl.value =
                                                          await Database().uploadPictureGetUrl(imageTempUrl.value);
                                                    }
                                                    await _postController.add(
                                                        body: bodyController.text.trim(),
                                                        category: categorySelected.value.trim(),
                                                        userHandle: _userController.user.email!,
                                                        userName: _userController.user.name!,
                                                        userImage: _userController.user.userImage!,
                                                        postImage: _postController.imageTempUrl.value,
                                                        actionData: selectedDate.value,
                                                        subCategorie: subcategorySelected.value);
                                                  }
                                                  isLoading.value = false;
                                                  Get.snackbar(
                                                    'Sucesso!',
                                                    '"Postagem concluida!',
                                                    snackPosition: SnackPosition.TOP,
                                                    duration: Duration(seconds: 5),
                                                    colorText: Colors.white,
                                                  ).show();
                                                } catch (e) {
                                                  isLoading.value = false;
                                                  Get.snackbar(
                                                    'Erro!',
                                                    'Infelizmente não foi possivel salvar as informações!',
                                                    snackPosition: SnackPosition.TOP,
                                                    backgroundColor: corPrimaria,
                                                    duration: Duration(seconds: 5),
                                                    colorText: Colors.white,
                                                  ).show();
                                                }
                                              } else {
                                                isLoading.value = false;
                                                Get.snackbar(
                                                  'Erro!',
                                                  'Opa, Preencha o campo de texto!',
                                                  snackPosition: SnackPosition.TOP,
                                                  backgroundColor: corPrimaria,
                                                  duration: Duration(seconds: 5),
                                                  colorText: Colors.white,
                                                ).show();
                                              }
                                            },
                                            iconeBotao: Icon(Icons.save, size: 20, color: Colors.white),
                                            textoBotao: Get.arguments != null ? "Atualizar" : "Postar",
                                          )
                                        : Container(
                                            height: 20,
                                            width: 20,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                  valueColor: AlwaysStoppedAnimation(corPrimariaClara)),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_postController.isEditing.value)
                          BotaoSimples(
                            textoBotao: "Deletar",
                            width: MediaQuery.of(context).size.width / 2.8,
                            executarAcao: () {
                              Get.dialog(AlertDialog(
                                title: Text("Deseja deletar o seu Post?"),
                                actions: [
                                  BotaoSimples(
                                    textoBotao: "Cancelar",
                                    width: MediaQuery.of(context).size.width / 2.8,
                                    executarAcao: () {
                                      Get.close(0);
                                    },
                                  ),
                                  BotaoSimples(
                                    textoBotao: "Deletar",
                                    width: MediaQuery.of(context).size.width / 2.8,
                                    executarAcao: () {
                                      Database().deletePost(
                                        id: model.id!,
                                        imageUrl: model.postImage!,
                                      );
                                      Get.close(0);
                                      Get.close(0);
                                    },
                                  )
                                ],
                              ));
                            },
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        }),
      ),
    );
  }

  void imageSelected(File? image) async {
    if (image != null) {
      CroppedFile? croppedImage = await ImageCropper.platform.cropImage(sourcePath: image.path);

      imageTempUrl.value = File(croppedImage!.path);
    }
  }
}
