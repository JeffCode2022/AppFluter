import 'dart:convert';
import 'dart:io';
import 'package:delivery_autonoma/src/models/response_api.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/users_provider.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class SignUpControllers  {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  File? imageFile;
  Function? refresh;

  ProgressDialog? _progressDialog;

  bool isEnable = true;

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    await usersProvider.init(context);
    // ignore: use_build_context_synchronously
    _progressDialog = ProgressDialog(context: context);
    refresh();
  }

  Future<void> signup() async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty ||
        name.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackBar.warningSnackBar(
          title: 'Campos vacíos', message: 'Llena todos los campos');
      return;
    }

    if (password != confirmPassword) {
      MySnackBar.errorSnackBar(
          title: 'Error', message: 'Las contraseñas no coinciden');
      return;
    }

    if (password.length < 6) {
      MySnackBar.warningSnackBar(
          title: 'Error', message: 'Contraseña muy corta, mínimo 6 caracteres');
      return;
    }

    if (phone.length < 9) {
      MySnackBar.warningSnackBar(
          title: 'Error', message: 'Número de teléfono inválido');
      return;
    }

    if (imageFile == null) {
      MySnackBar.warningSnackBar(
          title: 'Error', message: 'Selecciona una imagen');
      return;
    }

    _progressDialog!.show(max: 100, msg: 'Espere un momento...');
    isEnable = false;

    User user = User(
        email: email,
        name: name,
        lastname: lastName,
        phone: phone,
        password: password,
        roles: []);
    
    Stream? stream = await usersProvider.createWithImage(user, imageFile);
    stream?.listen((res) {
      _progressDialog!.update(value: 50, msg: 'Procesando...');

      _progressDialog!.close();


      // Manejar la respuesta del servidor
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      // ignore: avoid_print
      print('RESPUESTA: ${responseApi.toJson()}');
      MySnackBar.successSnackBar(
          title: 'Registro exitoso', message: 'Iniciando sesión');

      if (responseApi.success!) {
        // Si el registro es exitoso, redirigir al usuario a la pantalla de inicio de sesión después de 3 segundos
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context!, 'login');
        });
      } else {
        isEnable = true;
      }
    });
  }

  Future<void> selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: source);
    if (file != null) {
      imageFile = File(file.path);
      // ignore: avoid_print
      print('IMAGEN SELECCIONADA: ${imageFile!.path}');
      refresh!();
    }
    Navigator.pop(context!);
  }

  void showAlertDialog() {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona tu imagen'),
          actions: [
            ElevatedButton(
                onPressed: () => selectImage(ImageSource.gallery),
                child: const Text('Galería')),
            ElevatedButton(
                onPressed: () => selectImage(ImageSource.camera),
                child: const Text('Cámara')),
          ],
        );
      },
    );
  }

  void back() {
    Navigator.pop(context!);
  }
}
