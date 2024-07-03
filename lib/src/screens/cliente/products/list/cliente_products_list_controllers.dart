import 'dart:async';

import 'package:delivery_autonoma/src/models/category.dart';
import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/categories_provider.dart';
import 'package:delivery_autonoma/src/provider/orders_provider.dart';
import 'package:delivery_autonoma/src/provider/products_provider.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';

import '../details/cliente_products_detail_page.dart';

class ClientProductsListControllers {
  BuildContext? context;
  final SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  Function? refresh;
  Product? product;
  int counter = 1;
  User? user;

   Timer? searchOnStoppedTyping;

  String productName = '';
  final CategoriesProvider _categoriesProvider = CategoriesProvider();
  final ProductsProvider _productsProvider = ProductsProvider();
  final OrdersProvider _ordersProvider = OrdersProvider();
  List<Category> categories = [];
  bool isUpdate = false;

  List<Product> selectedProducts = [];

  Order order = Order();

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    user = User.fromJson(await _sharedPref.read('user'));
    if (user == null) {
      // Manejar el caso en que user es null
      print('User is null. Cannot proceed.');
      return;
    }

    selectedProducts =
        Product.fromJsonList(await _sharedPref.read('order')).toList();
    for (var p in selectedProducts) {
      print('Producto seleccionado: ${p.toJson()}');
    }

    _productsProvider.init(context, user!);
    _categoriesProvider.init(context, user!);
    _ordersProvider.init(context, user!);

    getCategories();
    refresh();
  }

   void onChangeText(String text) {
    const duration = Duration(milliseconds:800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping!.cancel();
      refresh!();
    }

    searchOnStoppedTyping =  Timer(duration, () {
      productName = text;
      refresh!();
      // getProducts(idCategory, text)
      print('TEXTO COMPLETO $text');
    });
  }

  Future<List<Product>> getProducts(String idCategory) async {

    if (productName.isNotEmpty) {
      return await _productsProvider.getByCategoryAndProductName(idCategory, productName);
    }

    return await _productsProvider.getByCategory(idCategory);
  }

  void getCategories() async {

    categories = await _categoriesProvider.getAll();
    refresh!();
  }

  void openBottomSheet(Product product) async {
    if (context != null) {
      final result = await showModalBottomSheet<bool>(
        isScrollControlled: true,
        context: context!,
        builder: (context) => ClientProductsDetailPage(product: product),
      );

      isUpdate = result ?? false;

      if (isUpdate) {
        refresh!();
      }
    } else {
      print('Context is null. Cannot open bottom sheet.');
    }
  }

void addToBag(Product product) {
  int index = selectedProducts.indexWhere((p) => p.id == product.id);

  if (index == -1) {
    // PRODUCTOS SELECCIONADOS NO EXISTE ESE PRODUCTO
    product.quantity ??= 1;  // Asignar 1 si product.quantity es null

    selectedProducts.add(product);
  } else {
    selectedProducts[index].quantity = counter;
  }

  _sharedPref.save('order', selectedProducts);
  MySnackBar.successSnackBar(
      title: 'Producto agregado', message: 'Producto agregado al carrito');
  print('Producto agregado al carrito: ${product.toJson()}');
  print('Productos seleccionados: ${selectedProducts.length}');
  refresh!();
  Navigator.of(context!);
}


  void logout() {
    if (context != null && user != null) {
      _sharedPref.logout(context!, user!.id);
    } else {
      print('Context or user is null. Cannot log out.');
    }
  }

  void goToMyOrders() {
    if (context != null) {
      Navigator.pushNamed(context!, 'client/orders/list');
    } else {
      print('Context is null. Cannot navigate.');
    }
  }

  void openDrawer() {
    key.currentState?.openDrawer();
  }

  void goToUpdate() {
    if (context != null) {
      Navigator.pushNamed(context!, 'client/update');
    } else {
      print('Context is null. Cannot navigate.');
    }
  }

  void goToOrderBagg() {
    if (context != null) {
      Navigator.pushNamed(context!, 'client/orders/create');
    } else {
      print('Context is null. Cannot navigate.');
    }
  }

  void goToRoles() {
    if (context != null) {
      Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
    } else {
      print('Context is null. Cannot navigate.');
    }
  }
}
