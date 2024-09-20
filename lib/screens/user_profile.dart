import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unna/models/post.dart';
import 'package:unna/screens/category_add_edit.dart';
import 'package:unna/widgets/post_card.dart';
import '../common/botao_simples.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../screens/debug_admin.dart';
import '../services/database.dart';
import '../utils/colors.dart';

// ignore: must_be_immutable
class UserProfileScreen extends StatelessWidget {
  final TextEditingController aboutTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();

  static String title = 'Perfil';

  UserController _userController = Get.find<UserController>();
  var imageTempUrl = File("").obs;
  var isGrid = true.obs;
  var isLoading = false.obs;

  Widget userInfoDetail(String info, String number) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(number, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: corBlack)),
        Text(info, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: corBlack)),
      ],
    );
  }

  int getLikesCounts(List<PostModel> posts) {
    int count = 0;
    for (var element in posts) {
      count += element.likeCount!;
    }
    return count;
  }

  int getCommentsCounts(List<PostModel> posts) {
    int count = 0;
    for (var element in posts) {
      count += element.commentCount!;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    nameTextController.text = _userController.user.name ?? "";
    aboutTextController.text = _userController.user.about ?? "";

    _userController.imageTempUrl.value = _userController.user.userImage ?? '';

    return Scaffold(
        backgroundColor: corFundoClara,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => !isLoading.value
                                    ? IconButton(
                                        onPressed: () async {
                                          print("\n\n* SALVAR PROFILE \n");
                                          isLoading.value = true;
                                          _userController.imageTempUrl.value =
                                              await Database().uploadPictureGetUrl(imageTempUrl.value);

                                          if ((nameTextController.text.trim() != '')) {
                                            await _userController.edit(
                                                id: _userController.user.id!,
                                                about: aboutTextController.text.trim(),
                                                name: nameTextController.text.trim(),
                                                userImage: _userController.imageTempUrl.value);
                                            imageTempUrl.value = File("");
                                            isLoading.value = false;
                                            Get.snackbar(
                                              'Sucesso!',
                                              'Atualização concluida!',
                                              snackPosition: SnackPosition.TOP,
                                              duration: Duration(seconds: 5),
                                              colorText: Colors.white,
                                            );
                                          } else {
                                            isLoading.value = false;
                                            Get.snackbar(
                                              'Opa, ta errado manolo',
                                              'Preenche os campos direito que vai!',
                                              snackPosition: SnackPosition.TOP,
                                              duration: Duration(seconds: 5),
                                              colorText: Colors.white,
                                            );
                                          }
                                        },
                                        icon: Icon(
                                          Icons.save,
                                        ),
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
                              Text(
                                title,
                                style: TextStyle(
                                    color: corBlack,
                                    fontSize: constraints.maxWidth * 0.06,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.find<AuthController>().signOut();
                                },
                                icon: Icon(
                                  Icons.logout,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          StreamBuilder<QuerySnapshot<PostModel>>(
                            stream: Database().getPostsWithId(email: _userController.user.email ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Scaffold(
                                  backgroundColor: corFundoClara,
                                  body: Center(
                                    child:
                                        CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(corPrimariaClara)),
                                  ),
                                );
                              }
                              if (snapshot.hasError || snapshot.data == null) {
                                return Scaffold(
                                    backgroundColor: corFundoClara,
                                    body: Center(child: Text("Erro ao carregar Posts")));
                              }
                              List<PostModel> posts = List.generate(
                                  snapshot.data!.docs.length, (index) => snapshot.data!.docs[index].data());
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          imageTempUrl.value = File("");
                                          final ImagePicker picker = ImagePicker();
                                          XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                          if (image != null) {
                                            imageSelected(File(image.path));
                                          }
                                        },
                                        child: Obx(() => imageTempUrl.value.path == ''
                                            ? CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: constraints.maxWidth * 0.15,
                                                backgroundImage: CachedNetworkImageProvider(
                                                  _userController.imageTempUrl.value,
                                                ),
                                              )
                                            : Container(
                                                height: 120,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.photo_size_select_actual,
                                                        color: Colors.white,
                                                        size: 40,
                                                      ),
                                                      Text(
                                                        "Defina\nImagem",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            color: Colors.white),
                                                      ),
                                                    ]),
                                              )),
                                      ),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          userInfoDetail("Likes", getLikesCounts(posts).toString()),
                                          userInfoDetail("Posts", posts.length.toString()),
                                          userInfoDetail("Comments", getCommentsCounts(posts).toString())
                                        ],
                                      ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.95,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                          borderSide: BorderSide(width: 2, color: corPrimaria),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                            borderSide: BorderSide(width: 2, color: corPrimaria)),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        label: Text('Nome'),
                                        labelStyle: TextStyle(color: corPrimariaEscura),
                                      ),
                                      controller: nameTextController,
                                      autocorrect: false,
                                      style: TextStyle(color: corBlack),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  if (posts.isNotEmpty)
                                    Obx(() {
                                      return isGrid.value
                                          ? GridView.builder(
                                              shrinkWrap: true,
                                              itemCount: posts.length,
                                              primary: false,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                              itemBuilder: (context, index) => Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    isGrid.value = false;
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(15),
                                                    child: Container(
                                                      child: CachedNetworkImage(
                                                        imageUrl: posts[index].postImage!,
                                                        placeholder: (context, url) => CircularProgressIndicator(
                                                          valueColor: AlwaysStoppedAnimation(
                                                            corBlack,
                                                          ),
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : ListView.builder(
                                              primary: false,
                                              shrinkWrap: true,
                                              itemCount: posts.length,
                                              itemBuilder: (context, index) => GestureDetector(
                                                onTap: () {
                                                  isGrid.value = true;
                                                },
                                                child: PostCard(
                                                  post: posts[index],
                                                  isIgnoring: true,
                                                ),
                                              ),
                                            );
                                    })
                                  else
                                    SizedBox(
                                      height: constraints.maxHeight * 0.1,
                                      child: Center(
                                        child: Text("Você ainda não postou nada"),
                                      ),
                                    ),
                                  Tooltip(
                                    message: 'Excluir conta',
                                    child: IconButton(
                                      onPressed: () {
                                        Get.find<AuthController>().signOut();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    if (_userController.user.role == 'admin')
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Admin...',
                                style: TextStyle(color: corBlack, fontSize: 25, fontWeight: FontWeight.w300)),
                            SizedBox(height: 10),
                            BotaoSimples(
                              executarAcao: () async {
                                Get.to(CategoryAddEditScreen());
                              },
                              iconeBotao: Icon(Icons.filter_1_outlined, size: 20, color: Colors.white),
                              textoBotao: "Categoria - Gerenciar",
                            ),
                            SizedBox(height: 10),
                            BotaoSimples(
                              executarAcao: () async {
                                Get.to(DebugAdminScreen());
                              },
                              iconeBotao: Icon(Icons.add_circle_outline, size: 20, color: Colors.white),
                              textoBotao: "Operacoes Especiais",
                            )
                          ],
                        ),
                      )
                  ],
                ),
              );
            }),
          ),
        ));
  }

  void imageSelected(File? image) async {
    if (image != null) {
      CroppedFile? croppedImage = await ImageCropper.platform.cropImage(sourcePath: image.path);

      print("\n\n\nCHEGUEI AQUI");
      if (croppedImage != null) {
        _userController.imageTempUrl.value = await Database().uploadPictureGetUrl(File(croppedImage.path));
      }
    }
  }
}
