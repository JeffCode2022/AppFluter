import 'package:delivery_autonoma/src/models/category.dart';
<<<<<<< HEAD
import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/categories_provider.dart';
import 'package:delivery_autonoma/src/provider/orders_provider.dart';
=======
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/categories_provider.dart';
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
import 'package:delivery_autonoma/src/provider/products_provider.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';

import '../details/cliente_products_detail_page.dart';

class ClientProductsListControllers {
  BuildContext? context;
  final SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;

  User? user;
  final CategoriesProvider _categoriesProvider = CategoriesProvider();
  final ProductsProvider _productsProvider = ProductsProvider();
<<<<<<< HEAD
  final OrdersProvider _ordersProvider = OrdersProvider();
  List<Category> categories = [];
  bool isUpdate = false;

  List<Product> selectedProducts = [];

  Order order = Order();
=======
  List<Category> categories = [];
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
<<<<<<< HEAD

    user = User.fromJson(await _sharedPref.read('user'));
    selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList();
=======
    user = User.fromJson(await _sharedPref.read('user'));
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
    // ignore: use_build_context_synchronously
    _productsProvider.init(context, user!);
    // ignore: use_build_context_synchronously
    _categoriesProvider.init(context, user!);
<<<<<<< HEAD

    // ignore: use_build_context_synchronously
    _ordersProvider.init(context, user!);

=======
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
    getCategories();
    refresh();
  }

  Future<List<Product>> getProducts(String idCategory) async {
    return await _productsProvider.getByCategory(idCategory);
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh!();
  }

<<<<<<< HEAD
  void openBottomSheet(Product product) async {
    final result = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      context: context!,
      builder: (context) => ClientProductsDetailPage(product: product),
    );

    // Ensure result is not null and is a bool type
    isUpdate = result ?? false;

    if (isUpdate) {
      refresh!();
    }
  }

  void logout() {
    _sharedPref.logout(context!, user!.id);
  }
  void goToMyOrders() {
    Navigator.pushNamed(context!, 'client/orders/list');
=======
  void openBottomSheet(Product product) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context!,
        builder: (context) => ClientProductsDetailPage(product: product));
  }

  void logout() {
    _sharedPref.logout(context!, user!.id!);
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
  }

  void openDrawer() {
    key.currentState!.openDrawer();
  }

  void goToUpdate() {
    Navigator.pushNamed(context!, 'client/update');
  }

  void goToOrderBagg() {
    Navigator.pushNamed(context!, 'client/orders/create');
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
  }
}
