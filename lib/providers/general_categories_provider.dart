import 'package:flutter/material.dart';
import 'package:unna/models/category.dart';

class GeneralCategoryProvider extends ChangeNotifier {
  String textSearchProduct = '';
  List<CategoryModel> products = [];
  TextEditingController controllerSearchProducts = TextEditingController();
  ScrollController listScrollController = ScrollController();
  FocusNode focusSearch = FocusNode();
  bool searchVisible = false;
  bool hasNextPage = false;
  bool makingRequest = false;
  bool makingPagination = false;
  bool showMessageWithoutNetwork = true;
  int page = 0;
  int amount = 0;

  void setSearchVisible(bool value) {
    searchVisible = value;
    notifyListeners();
  }

  void setHasNextPage(bool value) {
    hasNextPage = value;
    notifyListeners();
  }

  void setMakingRequest(bool value) {
    makingRequest = value;
    notifyListeners();
  }

  void setMakingPagination(bool value) {
    makingPagination = value;
    notifyListeners();
  }

  void setPage(int value) {
    page = value;
    notifyListeners();
  }

  void setAmount(int value) {
    amount = value;
    notifyListeners();
  }

  void setTextSearchProduct(String value) {
    textSearchProduct = value;
    notifyListeners();
  }

  void setProducts(List<CategoryModel> value) {
    products = value;
    notifyListeners();
  }

  void setControllerSearchProducts(TextEditingController value) {
    controllerSearchProducts = value;
    notifyListeners();
  }

  void setFocusSearch(FocusNode value) {
    focusSearch = value;
    notifyListeners();
  }

  void setShowMessageWithoutNetwork(bool value) {
    showMessageWithoutNetwork = value;
    notifyListeners();
  }

  void setListScrollController(ScrollController value) {
    listScrollController = value;
    notifyListeners();
  }
}
