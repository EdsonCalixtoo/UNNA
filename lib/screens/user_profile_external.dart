import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/models/post.dart';
import 'package:unna/services/database.dart';
import '../common/appbar_profile.dart';
import '../controllers/post_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/colors.dart';
import '../widgets/post_card_simple.dart';

class ProfileExternalScreen extends StatefulWidget {
  @override
  _ProfileExternalScreenState createState() => _ProfileExternalScreenState();
}

class _ProfileExternalScreenState extends State<ProfileExternalScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        final UserController userController = Get.put(UserController());

        Get.find<PostController>().getMore(quantity: 10, userId: userController.user.id!);
      }
    });

    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<PostModel>>(
      stream: Database().getPostsWithId(email: Get.arguments['userHandle']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: corFundoClara,
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(corPrimariaClara),
              ),
            ),
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            backgroundColor: corFundoClara,
            body: Center(
              child: Text(
                "Erro ao carregar Posts",
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: corFundoClara,
          appBar: AppBarProfile(
            height: 280,
            posts: List.generate(
              snapshot.data!.docs.length,
              (index) => snapshot.data!.docs[index].data(),
            ),
            userImage: Get.arguments['userImage'],
            userName: Get.arguments['userName'],
          ),
          body: Stack(
            children: [
              Container(
                height: 40,
                width: 35,
                child: Container(),
                color: corPrimaria,
              ),
              Container(
                height: 40,
                width: 35,
                decoration: BoxDecoration(
                  color: corFundoClara,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: Container(),
              ),
              Builder(
                builder: (context) {
                  if (snapshot.data!.docs.length != 0) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new PostCardSimple(post: snapshot.data!.docs[index].data());
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'nenhum post no momento',
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
