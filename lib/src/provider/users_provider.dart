import 'dart:convert';
import 'dart:io';
import 'package:delivery_autonoma/src/api/enviroment.dart';
import 'package:delivery_autonoma/src/models/response_api.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UsersProvider {
  final String _url = Enviroment.API_DELIVERY;
  // ignore: prefer_final_fields
  String _api = '/api/users';

  BuildContext? context;
  User? sessionUser;

  Future init(BuildContext context, {User? sessionUser}) async {
    this.context = context;
    this.sessionUser = sessionUser;
    return null;
  }

//--- crear usuario con imagen
  Future<Stream?> createWithImage(User user, File? image) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);

      if (image != null) {
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }

      request.fields['user'] = json.encode(user);
      final response = await request.send(); // ENVIARA LA PETICION
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      return null;
    }
  }

  Future<User?> getById(String id) async {
    try {
      Uri url = Uri.http(_url, '$_api/findById/$id');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 401) {
        SharedPref().logout(context!, sessionUser!.id!);
        MySnackBar.warningSnackBar(title: 'Error', message: 'Token expirado');
      }
      final data = jsonDecode(response.body);
      User user = User.fromJson(data);

      return user;
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      return null;
    }
  }

  Future<List<User>> getDeliveryMen() async {
    try {
      Uri url = Uri.http(_url, '$_api/findDeliveryMan');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        // NO AUTORIZADO
        MySnackBar.warningSnackBar(title: 'Error', message: 'Token expirado');
        SharedPref().logout(context!, sessionUser!.id!);
      }

      final data = json.decode(res.body);

      List<User> users = [];
      for (var user in data) {
        users.add(User.fromJson(user));
      }
      return users;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  ///_-----------------UPDATE------------
  Future<Stream?> update(User user, File? image) async {
    try {
      // Construimos la URL de la API
      Uri url = Uri.http(_url, '$_api/update');

      // Creamos una solicitud multiparte
      final request = http.MultipartRequest('PUT', url);

      // Agregamos la autorización a los encabezados de la solicitud
      request.headers['Authorization'] = sessionUser!.sessionToken!;

      // Si se proporcionó una imagen, la agregamos a la solicitud
      if (image != null) {
        final fileStream = http.ByteStream(image.openRead().cast());
        final fileLength = await image.length();
        final fileName = basename(image.path);
        request.files.add(http.MultipartFile('image', fileStream, fileLength,
            filename: fileName));
      }

      // Agregamos los datos del usuario a los campos de la solicitud
      request.fields['user'] = json.encode(user);

      // Enviamos la solicitud
      final response = await request.send();

      // Comprobamos si la respuesta es 401 (No autorizado)
      if (response.statusCode == 401) {
        // Si la respuesta es 401, cerramos la sesión del usuario y mostramos un mensaje
        SharedPref().logout(context!, sessionUser!.id!);
        MySnackBar.warningSnackBar(title: 'Error', message: 'Token expirado');
      }

      // Decodificamos la respuesta y la devolvemos como una transmisión
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      // Si ocurre un error, lo imprimimos en la consola
      // ignore: avoid_print
      print('Error: $e');
      return null;
    }
  }

  ////-------------CREATE------------

  Future<ResponseApi?> create(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(user);

      Map<String, String> headers = {'Content-Type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = jsonDecode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      return null;
    }
  }

////-------------LOGIN------------
  Future<ResponseApi?> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({'email': email, 'password': password});

      Map<String, String> headers = {'Content-Type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = jsonDecode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      return null;
    }
  }

////----  Logout
  Future<ResponseApi?> logout(String idUser) async {
    try {
      Uri url = Uri.http(_url, '$_api/logout');
      String bodyParams = json.encode({'id': idUser});

      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = jsonDecode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      return null;
    }
  }
}
