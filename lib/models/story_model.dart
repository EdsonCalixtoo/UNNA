// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unna/models/user.dart';

enum StoryType {
  Text,
  Video,
  Image,
}

class StoryModel {
  final String id;
  final UserModel userModel;
  final StoryType type;
  final dynamic storyData;
  final Timestamp createdAt;

  StoryModel({
    required this.id,
    required this.userModel,
    required this.type,
    required this.storyData,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userModel': userModel.toMap(),
      'type': type.name,
      'storyData': storyData,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> storyData = [];
    if (map['type'] == "Image") {
      storyData = json.decode(map['storyData']);
    }
    return StoryModel(
      id: map['id'] as String,
      userModel: UserModel.fromMapMap(map['userModel'] as Map<String, dynamic>),
      type: map['type'] == "Text"
          ? StoryType.Text
          : map['type'] == "Video"
              ? StoryType.Video
              : StoryType.Image,
      storyData: map['type'] == "Text"
          ? map['storyData']
          : Uint8List.fromList(List<int>.generate(storyData.length, (index) => storyData[index])),
      createdAt: map['createdAt'] == null ? Timestamp.now() : map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryModel.fromJson(String source) => StoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  StoryModel copyWith({
    String? id,
    UserModel? userModel,
    StoryType? type,
    String? storyData,
    Timestamp? createdAt,
  }) {
    return StoryModel(
      id: id ?? this.id,
      userModel: userModel ?? this.userModel,
      type: type ?? this.type,
      storyData: storyData ?? this.storyData,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
