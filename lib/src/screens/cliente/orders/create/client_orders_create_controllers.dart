import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientOrdersCreateController {
  BuildContext? context;
  Function? refresh;

  Product? product;

  int counter = 1;
  double? productPrice;

  final SharedPref _sharedPref = SharedPref();

  List<Product> selectedProducts = [];
  double total = 0;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    selectedProducts =Product.fromJsonList(await _sharedPref.read('order')).toList();

    getTotal();
    refresh();
  }

  void getTotal() {
    total = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    selectedProducts.forEach((product) {
      total = total + (product.quantity! * product.price!);
    });
    refresh!();
  }

  void addItem(Product product) {
    int index = selectedProducts.indexWhere((p) => p.id == product.id);
    selectedProducts[index].quantity = selectedProducts[index].quantity! + 1;
    _sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void removeItem(Product product) {
    if (product.quantity! > 1) {
      int index = selectedProducts.indexWhere((p) => p.id == product.id);
      selectedProducts[index].quantity =
          (selectedProducts[index].quantity! - 1);
      _sharedPref.save('order', selectedProducts);
      getTotal();
    }
  }

  void deleteItem(Product product) {
    selectedProducts.removeWhere((p) => p.id == product.id);
    _sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void gotoAddressList() {
    Get.toNamed('client/address/list');
  }
}
