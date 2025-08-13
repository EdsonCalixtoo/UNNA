import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/controllers/post_controller.dart';
import 'package:unna/controllers/user_controller.dart';
import 'package:unna/models/post.dart';
import 'package:unna/screens/post_add_edit.dart';
import 'package:unna/screens/post_comment.dart';
import 'package:unna/screens/user_profile_external.dart';
import 'package:unna/utils/colors.dart';
import 'package:unna/utils/functions.dart';
import 'like_button.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isIgnoring;
  final PostController postController = Get.find<PostController>();
  final UserController userController = Get.find<UserController>();

  PostCard({
    super.key,
    required this.post,
    this.isIgnoring = false,
  });

  Widget imagePost(BuildContext context, String? urlImagem) {
    var widthSize = MediaQuery.of(context).size.width * 0.9;

    return GestureDetector(
      onTap: () {
        Get.to(
          PostCommentScreen(),
          arguments: post,
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: widthSize * 1.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  urlImagem ??
                      'https://firebasestorage.googleapis.com/v0/b/experimentosdiversos.appspot.com/o/zSocialImagens%2FtesteImage.png?alt=media&token=53a7bdf7-a9e2-4752-a11f-d0ccd074936c',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 20,
            bottom: 20,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(30),
                right: Radius.circular(0),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 15,
                  sigmaY: 15,
                ),
                child: Container(
                  width: 90,
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(31),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 30,
                      ),
                      Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                        size: 28,
                      ),
                      Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                        size: 28,
                      ),
                      Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withAlpha(153),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: post.userImage!,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.userHandle!.split('@')[0],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            Functions.dateTimeParseString(date: post.createdAt!.toDate(), setHours: true),
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  if (post.body != null && post.body!.isNotEmpty)
                    Text(
                      post.body!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
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
                    Get.to(
                      ProfileExternalScreen(),
                      arguments: {
                        'userImage': post.userImage,
                        'userHandle': post.userHandle,
                        'userName': post.userName,
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: corBlack.withAlpha(50),
                          blurRadius: 17,
                          offset: Offset(0, 12),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: post.userImage!,
                        height: 51,
                        width: 51,
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
                      Functions.dateTimeParseString(date: post.createdAt!.toDate(), setHours: true),
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
                          Get.to(
                            PostCommentScreen(),
                            arguments: post,
                          );
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          imagePost(context, post.postImage!),
        ],
      ),
    );
  }
}
