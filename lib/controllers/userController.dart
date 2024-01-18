import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unna/screens/start.dart';

import '../controllers/authController.dart';
import '../models/user.dart';
import '../screens/login.dart';
import '../services/database.dart';

class UserController extends GetxController {
  AuthController _authController = Get.find<AuthController>();
  Rx<UserModel> _userModel = UserModel().obs;
  var likes = [].obs;
  final imageTempUrl = ''.obs;
  final isLoading = false.obs;
  final userProfileData = <String, dynamic>{}.obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => this._userModel.value = value;

  Future init() async {
    bool isLogged = _authController.init();
    if (isLogged) {
      _userModel.value = await Database().getUser(_authController.user!.uid);
      _userModel.value.likes.forEach((like) {
        likes.add(like);
      });

      print('UserControle: likes=' + _userModel.value.likes.length.toString());
      Get.offAll(StartPage());
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.offAll(Login());
      });
    }
  }

  void clear() {
    _userModel.value = UserModel();
  }

  Future<void> edit(
      {required String id, required String name, required String about, required String userImage}) async {
    isLoading.value = true;
    Database().editUserProfile({
      'id': id,
      'name': name.trim(),
      'about': about.trim(),
      'userImage': userImage != '' ? userImage : 'https://eu.ui-avatars.com/api/?name=$name&background=random'
    });

    isLoading.value = false;
  }

  Future<String> uploadImageCard(var file) async {
    String res = await Database().uploadPictureGetUrl(file);
    return res;
  }

  Future<void> getUserProfileNumbers(String userHandle) async {
    isLoading.value = true;
    Map<String, dynamic> userData;
    userData = await Database().userProfileData(userHandle);
    this.userProfileData(userData);

    print('\n\n --- TERMINOU uploadImageCard');
    print(this.userProfileData.toString());

    isLoading.value = false;
  }
}
