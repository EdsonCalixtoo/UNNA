import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/controllers/category_controller.dart';
import 'package:unna/models/post.dart';
import 'package:unna/models/story_model.dart';
import 'package:unna/screens/sports_category.dart';
import 'package:unna/screens/story_page.dart';
import '../common/appbar_home.dart';
import '../controllers/add_new_story_controller.dart';
import '../controllers/postController.dart';
import '../controllers/userController.dart';
import '../services/database.dart';
import '../utils/colors.dart';
import '../widgets/postCard.dart';
import 'add_new_story.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scrollController = ScrollController();
  PostController postController = Get.find<PostController>();
  CategoryController _categoryController = Get.find<CategoryController>();
  String selectedFilter = 'geral';

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
    UserController _userController = Get.find<UserController>();
    final double heightMarginTop = MediaQuery.of(context).padding.top;
    final double heightMarginBottom = MediaQuery.of(context).padding.bottom;
    final double appBarHeight = AppBar().preferredSize.height;
    final double height =
        MediaQuery.of(context).size.height - appBarHeight - heightMarginTop - heightMarginBottom - kToolbarHeight;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: corFundoClara,
        appBar: AppBarHome(),
        extendBody: false,
        extendBodyBehindAppBar: false,
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 14),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: (width * 0.5) - 22,
                    width: (width * 0.5) - 22,
                    decoration:
                        BoxDecoration(color: corWhite, borderRadius: BorderRadius.circular(20), boxShadow: const [
                      BoxShadow(
                        color: corShadows,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 0),
                      )
                    ]),
                    child: TextButton(
                        onPressed: () {
                          Get.to(GeneralCategory());
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          fixedSize: Size((width * 0.5) - 22, (width * 0.5) - 22),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Center(
                            child: SizedBox(
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.fitbit_rounded, size: 50, color: corSilverSoft),
                              Text(
                                'Geral',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: corSilverSoft),
                              )
                            ],
                          ),
                        ))),
                  ),
                  Container(
                    height: (width * 0.5) - 22,
                    width: (width * 0.5) - 22,
                    decoration:
                        BoxDecoration(color: corWhite, borderRadius: BorderRadius.circular(20), boxShadow: const [
                      BoxShadow(
                        color: corShadows,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 0),
                      )
                    ]),
                    child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          fixedSize: Size((width * 0.5) - 22, (width * 0.5) - 22),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Center(
                            child: SizedBox(
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.pets_rounded, size: 50, color: corSilverSoft),
                              Text(
                                'Pets',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: corSilverSoft),
                              )
                            ],
                          ),
                        ))),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: (width * 0.5) - 22,
                    width: (width * 0.5) - 22,
                    decoration:
                        BoxDecoration(color: corWhite, borderRadius: BorderRadius.circular(20), boxShadow: const [
                      BoxShadow(
                        color: corShadows,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 0),
                      )
                    ]),
                    child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          fixedSize: Size((width * 0.5) - 22, (width * 0.5) - 22),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Center(
                            child: SizedBox(
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.sports_handball_rounded, size: 50, color: corSilverSoft),
                              Text(
                                'Esportes',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: corSilverSoft),
                              )
                            ],
                          ),
                        ))),
                  ),
                  Container(
                    height: (width * 0.5) - 22,
                    width: (width * 0.5) - 22,
                    decoration:
                        BoxDecoration(color: corWhite, borderRadius: BorderRadius.circular(20), boxShadow: const [
                      BoxShadow(
                        color: corShadows,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 0),
                      )
                    ]),
                    child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          fixedSize: Size((width * 0.5) - 22, (width * 0.5) - 22),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Center(
                            child: SizedBox(
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.park_rounded, size: 50, color: corSilverSoft),
                              Text(
                                'Lazer',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: corSilverSoft),
                              )
                            ],
                          ),
                        ))),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: (width * 0.5) - 22,
                    width: (width * 0.5) - 22,
                    decoration:
                        BoxDecoration(color: corWhite, borderRadius: BorderRadius.circular(20), boxShadow: const [
                      BoxShadow(
                        color: corShadows,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 0),
                      )
                    ]),
                    child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          fixedSize: Size((width * 0.5) - 22, (width * 0.5) - 22),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Center(
                            child: SizedBox(
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.hail_rounded, size: 50, color: corSilverSoft),
                              Text(
                                'Valuntariados',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: corSilverSoft),
                              )
                            ],
                          ),
                        ))),
                  ),
                ],
              ),
            ),
          ]),
        ))

        /*SingleChildScrollView(
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
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor),
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
                    tempStorys
                        .add(StoryModel.fromMap(snapshot.data!.docs[i].data()));
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
                      if (storys[i].first.userModel.id ==
                          _userController.user.id) {
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
                                    "Ops", "Você não tem story no momento",
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    colorText: Colors.white);
                              }
                            },
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: index == 0
                                  ? CachedNetworkImageProvider(
                                      _userController.user.userImage!)
                                  : CachedNetworkImageProvider(
                                      storys[index].first.userModel.userImage!),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          if (index == 0)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Get.dialog(AlertDialog(
                                    actionsAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    title: Text("Tipo do Story"),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).primaryColor),
                                        onPressed: () {
                                          Get.back();
                                          Get.dialog(Builder(
                                            builder: (context) {
                                              AddNewStoryController controller =
                                                  AddNewStoryController();
                                              String textStory = "";
                                              return AlertDialog(
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                title: Text("Texto do Story"),
                                                content: TextField(
                                                  onChanged: (value) {
                                                    textStory = value;
                                                  },
                                                  cursorColor: Theme.of(context)
                                                      .primaryColor,
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )),
                                                  ),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                            backgroundColor: Theme
                                                                    .of(context)
                                                                .primaryColor),
                                                    onPressed: () {
                                                      if (textStory
                                                          .trim()
                                                          .isNotEmpty) {
                                                        controller.sendStoryText(
                                                          textStory.trim(),
                                                        );
                                                      }
                                                    },
                                                    child: Obx(() =>
                                                        controller.isLoading.value
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5.0),
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation(
                                                                          Colors
                                                                              .white),
                                                                ),
                                                              )
                                                            : Text("Adicionar")),
                                                  )
                                                ],
                                              );
                                            },
                                          ));
                                        },
                                        child: Text("Tipo Texto"),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).primaryColor),
                                        onPressed: () {
                                          Get.back();
                                          Get.to(AddNewStory());
                                        },
                                        child: Text("Tipo Imagem"),
                                      )
                                    ],
                                  ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: corBlack,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
              StreamBuilder<QuerySnapshot<PostModel>>(
                stream: postController.getStreamPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(corPrimariaClara)),
                    );
                  }
                  if (snapshot.hasError || snapshot.data == null) {
                    return Center(child: Text("Erro ao carregar Posts"));
                  }
                  postController.listAllPosts.clear();
                  for (var element in snapshot.data!.docs) {
                    postController.listAllPosts.add(element.data());
                  }
                  postController.setFilter();

                  return Obx(() {
                    if (postController.filteredPosts.isEmpty) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: Text('nenhum post no momento')));
                    }
                    return ListView.builder(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 15),
                        shrinkWrap: true,
                        primary: false,
                        controller: scrollController,
                        itemCount: postController.filteredPosts.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return PostCard(
                            post: postController.filteredPosts[index],
                          );
                        });
                  });
                },
              ),              
            ],
          ),
        ),*/
        );
  }
}
