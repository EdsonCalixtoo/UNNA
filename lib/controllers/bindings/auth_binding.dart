import 'package:get/get.dart';
import 'package:unna/controllers/sub_category_controller.dart';
import '../auth_controller.dart';
import '../category_controller.dart';
import '../nav_controller.dart';
import '../post_controller.dart';
import '../user_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CategoryController>(CategoryController(), permanent: true);
    Get.put<SubCategoryController>(SubCategoryController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);
    Get.put<NavController>(NavController(), permanent: true);
    Get.put<PostController>(PostController(), permanent: true);
  }
}
