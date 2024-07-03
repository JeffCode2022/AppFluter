import 'dart:ui';

import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/provider/orders_provider.dart';
import 'package:delivery_autonoma/src/screens/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:delivery_autonoma/src/screens/restaurant/orders/detail/restaurant_orders_detail_page.dart';
import 'package:delivery_autonoma/src/screens/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/user.dart';

class RestaurantProductsListControllers {
  BuildContext? context;
  User? user;
  final SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  List<String> status = ['PAGADO', 'DESPACHADO', 'EN CAMINO', 'ENTREGADO'];
  bool isUpdate = false;

  final OrdersProvider _orderProvider = OrdersProvider();

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    // ignore: use_build_context_synchronously
    _orderProvider.init(context, user!);
    refresh();
  }

  Future<List<Order>> getOrders(String status) async {
    return await _orderProvider.getByStatus(status);
  }

  void logout() {
    _sharedPref.logout(context!, user!.id);
  }

  void goToCategoriesCreate() {
    Get.to(() => const RestaurantCategoriesCreatePage(),
        transition: Transition.rightToLeft);
  }

  void goToProductsCreate() {
    Get.to(() => const RestaurantProductsCreatePage(),
        transition: Transition.rightToLeft);
  }

  void openDrawer() {
    key.currentState!.openDrawer();
  }

  void goToRoles() {
    Navigator.popAndPushNamed(context!, 'roles');
  }

void openBottomSheet(BuildContext context, Order order, VoidCallback refresh) async {
  final result = await showModalBottomSheet<bool>(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            color: Colors.white.withOpacity(0.7),
            child: RestaurantOrderDetailPage(order: order),
          ),
        ),
      );
    },
  );

  bool isUpdate = result ?? false;

  if (isUpdate) {
    refresh();
  }
}
}
