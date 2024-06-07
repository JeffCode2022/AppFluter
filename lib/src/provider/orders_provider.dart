import 'dart:convert';
import 'package:delivery_autonoma/src/api/enviroment.dart';
import 'package:delivery_autonoma/src/models/address.dart';
import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/models/response_api.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrdersProvider {
  final String _url = Enviroment.API_DELIVERY;
  final String _api = '/api/orders';
  BuildContext? context;
  User? sessionUser;

  Future init(BuildContext context, User sessionUser) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<ResponseApi?> create(Order order) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(order);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };

      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        MySnackBar.warningSnackBar(title: 'Error', message: 'Token expirado');
        SharedPref().logout(context!, sessionUser!.id!);
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

  ////-------------GET------------
  Future<List<Order>> getByStatus(String status) async {
    try {
      Uri url = Uri.http(_url, '$_api/findByStatus/$status');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };

      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        MySnackBar.warningSnackBar(title: 'Error', message: 'Token expirado');
        SharedPref().logout(context!, sessionUser!.id!);
      }

      final data = json.decode(res.body);
      // ignore: avoid_print
      print(data);

      if (data is Map<String, dynamic> && data.containsKey('data')) {
        final orderData = data['data'] as List<dynamic>;

        Order order = Order();
        order.fromJsonList(orderData);
        // ignore: avoid_print
        print(order.toList); // Aquí debería imprimir la lista correctamente
        return order.toList;
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

  Future<ResponseApi?> updateToDispatched(Order order) async {
    try {
      Uri url = Uri.http(_url, '$_api/updateToDispatched');
      String bodyParams = json.encode(order);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };

      final res = await http.put(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        MySnackBar.warningSnackBar(title: 'Error', message: 'Token expirado');
        SharedPref().logout(context!, sessionUser!.id!);
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
