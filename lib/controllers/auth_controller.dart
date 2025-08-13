import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unna/models/user.dart';
import 'package:unna/screens/home.dart';
import 'package:unna/screens/login.dart';
import 'package:unna/screens/start.dart';
import 'package:unna/services/database.dart';
import 'user_controller.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> _firebaseUser = Rx<User?>(null);

  User? get user => _firebaseUser.value;

  bool init() {
    _firebaseUser.value = _auth.currentUser;
    if (_firebaseUser.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void createUser(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      UserModel _user = UserModel(
        id: user.user?.uid,
        name: name,
        email: user.user?.email,
        role: 'user',
      );
      if (await Database().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        Get.back();
      }

      Get.offAll(Home());
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      // UserCredential user = await _auth.signInWithEmailAndPassword(
      //     email: email.trim(), password: password,);
      // Get.find<UserController>().user =
      //     await Database().getUser(user.user!.uid);

      Get.offAll(StartPage());
    } catch (e) {
      print('3');
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
      Get.offAll(Login());
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
