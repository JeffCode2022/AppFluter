import 'dart:convert';
import 'package:delivery_autonoma/src/api/enviroment.dart';
import 'package:delivery_autonoma/src/models/category.dart';
import 'package:delivery_autonoma/src/models/response_api.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider {
<<<<<<< HEAD
  final String _url = Environment.API_DELIVERY;
=======
  final String _url = Enviroment.API_DELIVERY;
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
  final String _api = '/api/categories';
  BuildContext? context;
  User? sessionUser;

  Future init(BuildContext context, User sessionUser) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  ////-------------GET------------
 Future<List<Category>> getAll() async {
  try {
    Uri url = Uri.http(_url, '$_api/getAll');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': sessionUser!.sessionToken!
    };

    final res = await http.get(url, headers: headers);

    if (res.statusCode == 401) {
      MySnackBar.warningSnackBar(title: 'Error', message: 'Token expirado');
<<<<<<< HEAD
      SharedPref().logout(context!, sessionUser!.id);
=======
      SharedPref().logout(context!, sessionUser!.id!);
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
    }

    final data = json.decode(res.body);
    // ignore: avoid_print
    print(data);

    if (data is Map<String, dynamic> && data.containsKey('data')) {
      final categoriesData = data['data'] as List<dynamic>;

      Category category = Category();
      category.fromJsonList(categoriesData);
      // ignore: avoid_print
      print(category.toList); // Aquí debería imprimir la lista correctamente
      return category.toList;
    } else {
      // ignore: avoid_print
      print('Error: La respuesta JSON no contiene la clave "data"');
    }

    return [];
  } catch (e) {
    // ignore: avoid_print
    print('Error: $e');
    return [];
  }
}

  ////-------------CREATE------------

  Future<ResponseApi?> create(Category category) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(category);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };

      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        MySnackBar.warningSnackBar(title: 'Error', message: 'Token expirado');
<<<<<<< HEAD
        SharedPref().logout(context!, sessionUser!.id);
=======
        SharedPref().logout(context!, sessionUser!.id!);
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
      }

      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      return null;
    }
  }
}
