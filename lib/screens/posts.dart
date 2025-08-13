import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/controllers/add_new_story_controller.dart';
import 'package:unna/controllers/post_controller.dart';
import 'package:unna/controllers/user_controller.dart';
import 'package:unna/services/database.dart';
import 'package:unna/utils/colors.dart';
import 'package:unna/widgets/appbar_home.dart';
import 'package:unna/widgets/custom_nav_bar.dart';
import 'package:unna/models/post.dart';
import 'package:unna/models/story_model.dart';
import 'package:unna/screens/story_page.dart';
import 'package:unna/utils/functions.dart';
import 'package:unna/widgets/post_card.dart';
import 'add_new_story.dart';

class Posts extends StatefulWidget {
  final String category;
  final String? subCategory;

  const Posts({
    required this.category,
    this.subCategory,
  });

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final scrollController = ScrollController();
  PostController postController = Get.find<PostController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double heightMarginTop = MediaQuery.of(context).padding.top;
    final double heightMarginBottom = MediaQuery.of(context).padding.bottom;
    final double heightAppBar = AppBar().preferredSize.height;
    final double height = MediaQuery.of(context).size.height - heightMarginTop - heightAppBar - heightMarginBottom;
    final double width = MediaQuery.of(context).size.width;
    UserController _userController = Get.find<UserController>();

    return Stack(
      children: [
        Scaffold(
          backgroundColor: corFundoClara,
          appBar: AppBarHome(
            isHome: false,
            isFilter: true,
          ),
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: CustomNavBar(
            pageController: null,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: Database().getStorys(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: Center(
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasError || snapshot.data == null) {
                      return SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: Center(
                          child: Text("Erro ao carregar Storys"),
                        ),
                      );
                    }

                    List<StoryModel> tempStorys = [];
                    for (var i = 0; i < snapshot.data!.docs.length; i++) {
                      tempStorys.add(StoryModel.fromMap(snapshot.data!.docs[i].data()));
                    }

                    tempStorys.sort(
                      (a, b) {
                        if (a.userModel.id == b.userModel.id) {
                          return -1;
                        } else {
                          return 1;
                        }
                      },
                    );

                    List<List<StoryModel>> storys = [];
                    String curretId = "";
                    for (var i = 0; i < tempStorys.length; i++) {
                      if (curretId != tempStorys[i].userModel.id) {
                        curretId = tempStorys[i].userModel.id!;
                        storys.add([]);
                      }
                      if (curretId == tempStorys[i].userModel.id) {
                        storys.last.add(tempStorys[i]);
                      }
                    }

                    if (_userController.user.userImage != null) {
                      storys.sort(
                        (a, b) {
                          if (a.first.userModel.id == _userController.user.id) {
                            return -1;
                          } else {
                            return 1;
                          }
                        },
                      );
                    }

                    bool contain = false;
                    if (_userController.user.userImage != null) {
                      for (var i = 0; i < storys.length; i++) {
                        if (storys[i].first.userModel.id == _userController.user.id) {
                          contain = true;
                        }
                      }
                      if (contain == false) {
                        storys.insert(0, []);
                      }
                    }

                    return Container(
                      height: 70,
                      width: double.infinity,
                      child: ListView.separated(
                        padding: EdgeInsets.only(left: 15),
                        itemCount: storys.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(
                          width: 5,
                        ),
                        itemBuilder: (context, index) => Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (storys[index].isNotEmpty) {
                                  Get.to(StoryPage(
                                    storys: storys,
                                    initialPage: index,
                                  ));
                                } else {
                                  Get.snackbar(
                                    "Ops",
                                    "Você não tem story no momento",
                                    backgroundColor: Theme.of(context).primaryColor,
                                    colorText: Colors.white,
                                  );
                                }
                              },
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: index == 0
                                    ? CachedNetworkImageProvider(_userController.user.userImage!)
                                    : CachedNetworkImageProvider(storys[index].first.userModel.userImage!),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            ),
                            if (index == 0)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                      AlertDialog(
                                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                                        title: Text(
                                          "Tipo do Story",
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Theme.of(context).primaryColor),
                                            onPressed: () {
                                              Get.back();
                                              Get.dialog(
                                                Builder(
                                                  builder: (context) {
                                                    AddNewStoryController controller = AddNewStoryController();
                                                    String textStory = "";
                                                    return AlertDialog(
                                                      actionsAlignment: MainAxisAlignment.center,
                                                      title: Text(
                                                        "Texto do Story",
                                                      ),
                                                      content: TextField(
                                                        onChanged: (value) {
                                                          textStory = value;
                                                        },
                                                        cursorColor: Theme.of(context).primaryColor,
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Theme.of(context).primaryColor,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Theme.of(context).primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor: Theme.of(context).primaryColor),
                                                          onPressed: () {
                                                            if (textStory.trim().isNotEmpty) {
                                                              controller.sendStoryText(
                                                                textStory.trim(),
                                                              );
                                                            }
                                                          },
                                                          child: Obx(
                                                            () => controller.isLoading.value
                                                                ? Padding(
                                                                    padding: const EdgeInsets.all(5),
                                                                    child: CircularProgressIndicator(
                                                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    "Adicionar",
                                                                  ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Tipo Texto",
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Theme.of(context).primaryColor),
                                            onPressed: () {
                                              Get.back();
                                              Get.to(AddNewStory());
                                            },
                                            child: Text(
                                              "Tipo Imagem",
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: corBlack,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                StreamBuilder<QuerySnapshot<PostModel>>(
                  stream: postController.getStreamPosts(widget.category, widget.subCategory ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(corPrimariaClara),
                        ),
                      );
                    }
                    if (snapshot.hasError || snapshot.data == null) {
                      return Center(
                        child: Text(
                          "Erro ao carregar Posts",
                        ),
                      );
                    }
                    postController.listAllPosts.clear();
                    for (var element in snapshot.data!.docs) {
                      postController.listAllPosts.add(element.data());
                    }
                    postController.setFilter();

                    return Obx(
                      () {
                        if (postController.filteredPosts.isEmpty) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                'nenhum post no momento',
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.only(left: 8, right: 8, top: 15),
                          shrinkWrap: true,
                          primary: false,
                          controller: scrollController,
                          itemCount: postController.filteredPosts.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return PostCard(
                              post: postController.filteredPosts[index],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: postController.isOptionsFilterVisible.value,
            child: Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  postController.setOptionsFinishVisible(false);
                },
                child: Container(
                  color: Colors.black54,
                  height: height,
                  width: width,
                  child: GestureDetector(
                    onTapCancel: () {},
                    child: SimpleDialog(
                      surfaceTintColor: corWhite,
                      contentPadding: const EdgeInsets.only(
                        top: 12,
                        bottom: 18,
                        right: 20,
                        left: 20,
                      ),
                      insetPadding: width < 340
                          ? const EdgeInsets.only(right: 20, left: 20)
                          : EdgeInsets.only(right: width * 0.1, left: width * 0.1),
                      children: [
                        SizedBox(
                          width: width,
                          height: 200,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: const Text(
                                  'Filtrar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: corBlack,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                      value: postController.filterLiked.value,
                                      onChanged: (value) {
                                        postController.filterLiked.value = value!;
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
                                          "Data ação:",
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
                                            postController.filterDate.value = value;
                                            postController.setFilter();
                                          }
                                        });
                                      },
                                      child: Obx(
                                        () => Text(
                                          postController.filterDate.value == DateTime(1500)
                                              ? "Selecionar"
                                              : Functions.dateTimeParseString(
                                                  date: postController.filterDate.value, setHours: false),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.dialog(
                                        AlertDialog(
                                          title: Text(
                                            "Deseja limpar os filtros?",
                                          ),
                                          alignment: Alignment.center,
                                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                                          actions: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(backgroundColor: corSilverSoft),
                                              onPressed: () {
                                                Get.close(0);
                                              },
                                              child: Text("Cancelar"),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(backgroundColor: corPrimaria),
                                              onPressed: () {
                                                Get.close(0);
                                                postController.resetFilters();
                                              },
                                              child: Text("Limpar"),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.filter_alt_off,
                                      size: 32,
                                      color: corSilverSoft,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
