import 'dart:async';
import 'dart:convert';
import 'package:delivery_autonoma/src/provider/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(key) == null) return null;

    return json.decode(prefs.getString(key) ?? '{}');
  }

  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  void logout(BuildContext context, String idUser) async {
    UsersProvider usersProvider = UsersProvider();
    usersProvider.init(context);
    usersProvider.logout(idUser);
    await remove('user');
    Get.offAllNamed('login');
  }
}
