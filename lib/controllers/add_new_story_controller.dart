import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:get/get.dart';
import 'package:unna/models/story_model.dart';
import '../services/database.dart';
import 'user_controller.dart';

class AddNewStoryController extends GetxController {
  var indexSelected = 0.obs;
  var isLoading = false.obs;
  late Uint8List data;

  Future<List<Uint8List>> getGalery() async {
    GalleryMedia? snapshot = (await GalleryPicker.collectGallery) as GalleryMedia?;
    List<Uint8List> files = [];

    for (var i = 0; i < snapshot!.albums.length; i++) {
      if (snapshot.albums[i].name == "All" || snapshot.albums[i].name == "Todos") {
        for (var element in snapshot.albums[i].medias) {
          if (element.isImage) {
            Uint8List data = await element.getData();
            files.add(data);
          }
        }
      }
    }
    return files;
  }

  Future sendStoryImage() async {
    isLoading.value = true;
    UserController _userController = Get.find<UserController>();
    await Database().createStory(
      StoryModel(
        id: "",
        userModel: _userController.user,
        type: StoryType.Image,
        storyData: json.encode(data.toList()),
        createdAt: Timestamp.now(),
      ),
    );

    isLoading.value = false;
    Get.back();
    Get.back();
  }

  Future sendStoryText(String value) async {
    isLoading.value = true;
    UserController _userController = Get.find<UserController>();
    await Database().createStory(
      StoryModel(
        id: "",
        userModel: _userController.user,
        type: StoryType.Text,
        storyData: value,
        createdAt: Timestamp.now(),
      ),
    );

    isLoading.value = false;
    Get.back();
  }
}
