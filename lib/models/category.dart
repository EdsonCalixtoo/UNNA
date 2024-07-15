// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String name;
  String id;
  String icon;
  int order;
  List<String> subCategories;
  CategoryModel(
      {required this.name, required this.id, required this.icon, required this.order, required this.subCategories});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'id': id, 'icon': icon, 'order': order, 'subCategories': subCategories};
  }

  factory CategoryModel.fromMap(DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return CategoryModel(
        name: documentSnapshot.data()!['name'] as String,
        id: documentSnapshot.data()!['id'] as String,
        icon: documentSnapshot.data()!['icon'] as String,
        order: documentSnapshot.data()!['order'] as int,
        subCategories: List<String>.generate(documentSnapshot.data()!['subCategories'].length,
            (index) => documentSnapshot.data()!['subCategories'][index]));
  }

  factory CategoryModel.fromJson(Map<String, dynamic> documentSnapshot) {
    return CategoryModel(
        name: documentSnapshot['name'] as String,
        id: documentSnapshot['id'] as String,
        icon: documentSnapshot['icon'] as String,
        order: documentSnapshot['order'] as int,
        subCategories: List<String>.generate(
            documentSnapshot['subCategories'].length, (index) => documentSnapshot['subCategories'][index]));
  }

  String toJson() => json.encode(toMap());

  CategoryModel copyWith({
    String? name,
    String? id,
    String? icon,
    int? order,
    List<String>? subCategories,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      id: id ?? this.id,
      icon: icon ?? this.icon,
      order: order ?? this.order,
      subCategories: subCategories ?? this.subCategories,
    );
  }
}
