import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? about;
  String? userImage;
  String role;
  List<String> likes;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.about,
    this.userImage,
    this.likes = const [],
    this.role = 'user',
  });

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, userImage: $userImage, role: $role)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'about': about,
      'userImage': userImage,
      'role': role,
      'likes': likes,
    };
  }

  factory UserModel.fromMap(DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return UserModel(
        id: documentSnapshot.id,
        name: documentSnapshot.data()!['name'] != null ? documentSnapshot.data()!['name'] as String : null,
        email: documentSnapshot.data()!['email'] != null ? documentSnapshot.data()!['email'] as String : null,
        about: documentSnapshot.data()!['about'] != null ? documentSnapshot.data()!['about'] as String : null,
        userImage:
            documentSnapshot.data()!['userImage'] != null ? documentSnapshot.data()!['userImage'] as String : null,
        role: documentSnapshot.data()!['role'] as String,
        likes: documentSnapshot.data()!['likes'] != null
            ? List<String>.from(
                (documentSnapshot.data()!['likes']),
              )
            : []);
  }

  factory UserModel.fromMapMap(Map<String, dynamic> documentSnapshot) {
    return UserModel(
        id: documentSnapshot['id'] != null ? documentSnapshot['id'] as String : null,
        name: documentSnapshot['name'] != null ? documentSnapshot['name'] as String : null,
        email: documentSnapshot['email'] != null ? documentSnapshot['email'] as String : null,
        about: documentSnapshot['about'] != null ? documentSnapshot['about'] as String : null,
        userImage: documentSnapshot['userImage'] != null ? documentSnapshot['userImage'] as String : null,
        role: documentSnapshot['role'] as String,
        likes: documentSnapshot['likes'] != null
            ? List<String>.from(
                (documentSnapshot['likes']),
              )
            : []);
  }

  String toJson() => json.encode(toMap());
}
