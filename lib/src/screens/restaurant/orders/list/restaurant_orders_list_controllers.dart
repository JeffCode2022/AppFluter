import 'package:delivery_autonoma/src/screens/restaurant/categories/create/restaurant_categories_create_page.dart';
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

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }

  void logout() {
    _sharedPref.logout(context!, user!.id!);
  }
  void goToCategoriesCreate() {
    Get.to(() => const RestaurantCategoriesCreatePage(), transition: Transition.rightToLeft);
  }
   void goToProductsCreate() {
    Get.to(() => const RestaurantProductsCreatePage(), transition: Transition.rightToLeft);
  }

  void openDrawer() {
    key.currentState!.openDrawer();
  }

  void goToRoles() {
    Navigator.popAndPushNamed(context!, 'roles');
  }
}
