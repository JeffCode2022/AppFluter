import 'dart:convert';
import 'dart:io';
import 'package:delivery_autonoma/src/api/enviroment.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class ProductsProvider {
  final String _url = Environment.API_DELIVERY;
  final String _api = '/api/products';
  BuildContext? context;
  User? sessionUser;

  Future init(BuildContext context, User sessionUser) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }

Future<List<Product>> getByCategory(String idCategory) async {
  try {
    Uri url = Uri.http(_url, '$_api/findByCategory/$idCategory');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': sessionUser!.sessionToken!
    };

    final res = await http.get(url, headers: headers);

    if (res.statusCode == 401) {
      MySnackBar.warningSnackBar(title: 'Error', message: 'Token expirado');
      SharedPref().logout(context!, sessionUser!.id);
    }

    final data = json.decode(res.body);
    final products = Product.fromJsonList(data);
    return products;

   
  } catch (e) {
    // ignore: avoid_print
    print('Error: $e');
    return [];
  }
}

  //--- crear usuario con imagen
  Future<Stream?> create(Product product, List<File?> image) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = sessionUser!.sessionToken!;

      for (int i = 0; i < image.length; i++) {
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(image[i]!.openRead().cast()),
            await image[i]!.length(),
            filename: basename(image[i]!.path)));
      }

      request.fields['product'] = json.encode(product);
      final response = await request.send(); // ENVIARA LA PETICION
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      return null;
    }
  }
}
