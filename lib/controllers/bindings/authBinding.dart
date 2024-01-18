import 'package:get/get.dart';

import '../authController.dart';
import '../category_controller.dart';
import '../navController.dart';
import '../postController.dart';
import '../userController.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CategoryController>(CategoryController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);
    Get.put<NavController>(NavController(), permanent: true);
    Get.put<PostController>(PostController(), permanent: true);
  }
}
