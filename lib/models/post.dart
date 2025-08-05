// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? body;
  String? category;
  String? userName;
  String? userHandle;
  String? userImage;
  String? postImage;
  String? id;
  int? commentCount;
  int? likeCount;
  Timestamp? createdAt;
  List<String>? likes = [];
  Timestamp? actionData;
  String? subCategorie;
  PostModel({
    this.body,
    this.category,
    this.userName,
    this.userHandle,
    this.userImage,
    this.postImage,
    this.id,
    this.commentCount,
    this.likeCount,
    this.createdAt,
    this.likes,
    this.actionData,
    this.subCategorie,
  });

  @override
  String toString() {
    return 'PostModel(id: $id, body: $body, category: $category, userName: $userName, userHandle: $userHandle, userImage: $userImage, postImage: $postImage, id: $id, commentCount: $commentCount, likeCount: $likeCount, createdAt: $createdAt)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
      'category': category,
      'userName': userName,
      'userHandle': userHandle,
      'userImage': userImage,
      'postImage': postImage,
      'id': id,
      'commentCount': commentCount,
      'likeCount': likeCount,
      'createdAt': createdAt != null ? createdAt!.millisecondsSinceEpoch : null,
      'likes': likes,
      'actionData': actionData,
      'subCategorie': subCategorie,
    };
  }

  factory PostModel.fromMap(
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
  ) {
    return PostModel(
      id: documentSnapshot.id,
      body: documentSnapshot.data()!["body"],
      category: documentSnapshot.data()!["category"],
      userName: documentSnapshot.data()!["userName"],
      userImage: documentSnapshot.data()!["userImage"],
      postImage: documentSnapshot.data()!["postImage"],
      userHandle: documentSnapshot.data()!["userHandle"],
      commentCount: documentSnapshot.data()!["commentCount"],
      likeCount: documentSnapshot.data()!["likeCount"],
      createdAt: documentSnapshot.data()!["createdAt"],
      likes: documentSnapshot.data()!['likes'] != null ? List<String>.from((documentSnapshot.data()!['likes'])) : [],
      actionData: documentSnapshot.data()!['actionData'] ?? documentSnapshot.data()!["createdAt"],
      subCategorie: documentSnapshot.data()!["subCategorie"],
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> documentSnapshot) {
    return PostModel(
      id: "",
      body: documentSnapshot["body"],
      category: documentSnapshot["category"],
      userName: documentSnapshot["userName"],
      userImage: documentSnapshot["userImage"],
      postImage: documentSnapshot["postImage"],
      userHandle: documentSnapshot["userHandle"],
      commentCount: documentSnapshot["commentCount"],
      likeCount: documentSnapshot["likeCount"],
      createdAt: documentSnapshot["createdAt"],
      likes: documentSnapshot['likes'] != null ? List<String>.from((documentSnapshot['likes'])) : [],
      actionData: documentSnapshot['actionData'] ?? documentSnapshot["createdAt"],
      subCategorie: documentSnapshot["subCategorie"],
    );
  }

  String toJson() => json.encode(toMap());

  PostModel copyWith(
      {String? body,
      String? category,
      String? userName,
      String? userHandle,
      String? userImage,
      String? postImage,
      String? id,
      int? commentCount,
      int? likeCount,
      Timestamp? createdAt,
      List<String>? likes,
      Timestamp? actionData,
      String? subCategorie}) {
    return PostModel(
      body: body ?? this.body,
      category: category ?? this.category,
      userName: userName ?? this.userName,
      userHandle: userHandle ?? this.userHandle,
      userImage: userImage ?? this.userImage,
      postImage: postImage ?? this.postImage,
      id: id ?? this.id,
      commentCount: commentCount ?? this.commentCount,
      likeCount: likeCount ?? this.likeCount,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      actionData: actionData ?? this.actionData,
      subCategorie: subCategorie ?? this.subCategorie,
    );
  }
}
