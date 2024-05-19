import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';

class DeliveryOrdersListController {
  BuildContext? context;
   
   final SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  User? user;
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

  void openDrawer() {
    key.currentState!.openDrawer();
  }

  void goToPage(String route) {
    Navigator.pushNamedAndRemoveUntil(context!, route, (route) => false);
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
  }
}
