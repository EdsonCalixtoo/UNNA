import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/screens/post_add_edit.dart';
import 'package:unna/utils/colors.dart';
import 'package:unna/utils/utils.dart';
import '../controllers/post_controller.dart';
import '../controllers/user_controller.dart';
import '../models/post.dart';
import '../screens/post_comment.dart';
import '../screens/user_profile_external.dart';
import 'like_button.dart';

// ignore: must_be_immutable
class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isIgnoring;

  PostCard({
    Key? key,
    required this.post,
    this.isIgnoring = false,
  }) : super(key: key);

  PostController postController = Get.find<PostController>();
  UserController userController = Get.find<UserController>();

  Widget imagePost(BuildContext context, String? urlImagem) {
    var widtSize = MediaQuery.of(context).size.width * 0.7;

    return IgnorePointer(
      ignoring: isIgnoring,
      child: GestureDetector(
        onTap: () {
          Get.to(PostCommentScreen(), arguments: post);
        },
        child: Stack(
          children: [
            Container(
              height: widtSize,
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  onError: (exception, stackTrace) => const Icon(Icons.error),
                  image: CachedNetworkImageProvider(
                    urlImagem ??
                        'https://firebasestorage.googleapis.com/v0/b/experimentosdiversos.appspot.com/o/zSocialImagens%2FtesteImage.png?alt=media&token=53a7bdf7-a9e2-4752-a11f-d0ccd074936c',
                  ),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15.0,
                    offset: Offset(1, 15.75),
                  )
                ],
                color: corPrimaria,
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),

            // Aba lateral fixa no canto direito
            Positioned(
              right: 12,
              top: 16,
              bottom: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    width: 60,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.01),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 28,
                        ),
                        Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white,
                          size: 26,
                        ),
                        Icon(
                          Icons.bookmark_border,
                          color: Colors.white,
                          size: 26,
                        ),
                        Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 26,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userLine() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: IgnorePointer(
            ignoring: isIgnoring,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(ProfileExternalScreen(), arguments: {
                      'userImage': post.userImage,
                      'userHandle': post.userHandle,
                      'userName': post.userName,
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: corBlack.withAlpha(50),
                          blurRadius: 17.0,
                          offset: Offset(0, 12),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: post.userImage!,
                        height: 51.0,
                        width: 51.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.userHandle!.split('@')[0],
                      style: TextStyle(
                        color: corBlack,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      Utils.dateTimeParseString(date: post.createdAt!.toDate(), setHours: true),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        if (userController.user.email == post.userHandle)
          IconButton(
            onPressed: () {
              Get.to(PostAddEditScreen(), arguments: post);
            },
            icon: Icon(
              Icons.more_horiz,
              size: 30,
            ),
          ),
      ],
    );
  }

  Widget textBody() {
    return post.body != ''
        ? Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Text(
                    post.body!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  Widget baseLine() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 70,
                      child: Row(
                        children: [
                          LikeButton(
                            isLiked: post.likes!.contains(userController.user.id),
                            onTap: () {
                              postController.toggleLike(userController.user.id!, post);
                            },
                          ),
                          Expanded(
                            child: Text(
                              post.likeCount! > 0 ? post.likeCount.toString() : '0',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 80,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(PostCommentScreen(), arguments: post);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              post.commentCount! > 0 ? CupertinoIcons.text_bubble_fill : CupertinoIcons.bubble_left,
                              size: 25,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 11,
                            ),
                            Expanded(
                              child: Text(
                                post.commentCount.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Column(
        children: [
          userLine(),
          SizedBox(height: 15),
          imagePost(context, post.postImage!),
          textBody(),
          baseLine(),
        ],
      ),
    );
  }
}
