import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/models/post.dart';
import '../utils/colors.dart';

class AppBarProfile extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final String userImage;
  final List<PostModel> posts;
  final String userName;

  AppBarProfile({Key? key, this.height, required this.userImage, required this.posts, required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int getLikesCounts() {
      int count = 0;
      for (var element in posts) {
        count += element.likeCount!;
      }
      return count;
    }

    int getCommentsCounts() {
      int count = 0;
      for (var element in posts) {
        count += element.commentCount!;
      }
      return count;
    }

    Widget userInfoDetail(String info, String number) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(number, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(info, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white)),
        ],
      );
    }

    Widget userAvatar() {
      return Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: corBlack.withAlpha(50),
              blurRadius: 17.0,
              offset: Offset(0, 12),
              spreadRadius: 1,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            imageUrl: this.userImage,
            height: 81.0,
            width: 81.0,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget userName(String name) {
      return Stack(
        children: [
          Container(color: corPrimaria, height: 155, child: Container()),
          Container(
            decoration: BoxDecoration(
                color: corFundoClara,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                )),
            height: 155,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                userAvatar(),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(this.userName, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget userInfo() {
      return Container(
        decoration: BoxDecoration(
            color: corPrimaria,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            )),
        height: 89,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              userInfoDetail('POSTS', posts.length.toString()),
              userInfoDetail('LIKES', getLikesCounts().toString()),
              userInfoDetail('COMMENTS', getCommentsCounts().toString()),
            ],
          ),
        ),
      );
    }

    return Container(
      height: height,
      color: corFundoClara.withAlpha(140),
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              userName(this.userName),
              userInfo(),
            ],
          ),
          Positioned(
            left: 5,
            top: 20,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.chevron_left_outlined,
                size: 40,
                color: corPrimaria,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
