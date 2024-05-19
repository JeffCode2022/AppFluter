import 'package:delivery_autonoma/src/models/category.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/categories_provider.dart';
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
  List<Category> categories = [];

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    // ignore: use_build_context_synchronously
    _productsProvider.init(context, user!);
    // ignore: use_build_context_synchronously
    _categoriesProvider.init(context, user!);
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

  void openBottomSheet(Product product) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context!,
        builder: (context) => ClientProductsDetailPage(product: product));
  }

  void logout() {
    _sharedPref.logout(context!, user!.id!);
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
