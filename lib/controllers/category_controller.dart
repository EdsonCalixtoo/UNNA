import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/category.dart';
import '../services/database.dart';

class CategoryController extends GetxController {
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  List<CategoryModel> categoryList = [];
  final categorySelected = "geral".obs;

  final isLoading = false.obs;
  final isEditing = false.obs;

  @override
  // ignore: must_call_super
  void onInit() {}

  @override
  void onClose() {
    super.onClose();
  }

  Stream<QuerySnapshot<CategoryModel>> getStreamCategories() {
    return Database().getStreamCategories();
  }

  Future<List<CategoryModel>> get(String category) async {
    List<CategoryModel> newCategories = [];
    newCategories = await Database().getCategories(category);

    print('---------------');
    print(newCategories[0].name);
    print(newCategories[0].subCategories);
    if (newCategories.length > 0) {
      categoryList.clear();
      newCategories.forEach((post) => categoryList.add(post));
    }

    categories.assignAll(newCategories);
    return newCategories;
  }

  Future<void> add(String name, String iconText, int order) async {
    isLoading.value = true;
    Database().addCategory({'name': name.trim(), 'iconText': iconText, 'order': order});
    isLoading.value = false;
  }

  Future<void> edit(String id, String name, String iconText, int order) async {
    isLoading.value = true;
    Database().editCategory({'id': id, 'name': name.trim(), 'iconText': iconText, 'order': order});
    isLoading.value = false;
  }
}
