import 'package:get/get.dart';
import 'package:unna/models/sub_category.dart';
import '../services/database.dart';

class SubCategoryController extends GetxController {
  RxList<SubCategoryModel> categories = <SubCategoryModel>[].obs;
  List<SubCategoryModel> subCategoryList = [];
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

  // Stream<QuerySnapshot<SubCategoryModel>> getStreamCategories() {
  //   return Database().getStreamSubCategories();
  // }

  Future<void> getSubCategories(String category) async {
    try {
      List<String> newCategories = await Database().getSubCategories(category);
      print('subcategories: $newCategories');

      List<SubCategoryModel> categoryModels = newCategories.map((name) => SubCategoryModel(name: name)).toList();

      categories.assignAll(categoryModels);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
