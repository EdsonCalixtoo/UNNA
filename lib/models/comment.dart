// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String body;
  String userHandle;
  String userImage;
  String id;
  String postId;
  String userName;
  Timestamp? dateCreatedAt;

  CommentModel({
    required this.body,
    required this.userHandle,
    required this.userImage,
    required this.id,
    required this.postId,
    required this.userName,
    required this.dateCreatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
      'userHandle': userHandle,
      'userImage': userImage,
      'id': id,
      'postId': postId,
      'userName': userName,
      'dateCreatedAt': dateCreatedAt?.millisecondsSinceEpoch,
    };
  }

  factory CommentModel.fromMap(DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return CommentModel(
      body: documentSnapshot.data()!['body'] as String,
      userHandle: documentSnapshot.data()!['userHandle'] as String,
      userImage: documentSnapshot.data()!['userImage'] as String,
      id: documentSnapshot.id,
      postId: documentSnapshot.data()!['postId'] as String,
      userName: documentSnapshot.data()!['userName'] as String,
      dateCreatedAt: documentSnapshot.data()!['dateCreatedAt'],
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> documentSnapshot) {
    return CommentModel(
      body: documentSnapshot['body'] as String,
      userHandle: documentSnapshot['userHandle'] as String,
      userImage: documentSnapshot['userImage'] as String,
      id: documentSnapshot["id"] ?? "",
      postId: documentSnapshot['postId'] as String,
      userName: documentSnapshot['userName'] as String,
      dateCreatedAt: documentSnapshot['dateCreatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  CommentModel copyWith({
    String? body,
    String? userHandle,
    String? userImage,
    String? id,
    String? postId,
    String? userName,
    Timestamp? dateCreatedAt,
  }) {
    return CommentModel(
      body: body ?? this.body,
      userHandle: userHandle ?? this.userHandle,
      userImage: userImage ?? this.userImage,
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userName: userName ?? this.userName,
      dateCreatedAt: dateCreatedAt ?? this.dateCreatedAt,
    );
  }
}
