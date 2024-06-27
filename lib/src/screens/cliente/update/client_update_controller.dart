import 'dart:convert';
import 'dart:io';
import 'package:delivery_autonoma/src/models/response_api.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/users_provider.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class ClienteUpdateController {
  BuildContext? context;
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final SharedPref _sharedPref = SharedPref();

  UsersProvider usersProvider = UsersProvider();
  File? imageFile;
  Function? refresh;
  User? user;

  ProgressDialog? _progressDialog;

  bool isEnable = true;

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // ignore: use_build_context_synchronously
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    // ignore: use_build_context_synchronously
    usersProvider.init(context,sessionUser: user);

    nameController.text = user!.name!;
    lastNameController.text = user!.lastname!;
    phoneController.text = user!.phone!;
    refresh();
  }

////-------------UPDATE------------
  Future<void> update() async {
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();
    String phone = phoneController.text.trim();

      //_-----------------validaciones----------------
    if (name.isEmpty || lastName.isEmpty || phone.isEmpty) {
      MySnackBar.warningSnackBar(
          title: 'Campos vacíos', message: 'Llena todos los campos');
      return;
    }

    if (phone.length < 9) {
      MySnackBar.warningSnackBar(
          title: 'Error', message: 'Número de teléfono inválido');
      return;
    }

        ////-----------------progress dialog----------------
    _progressDialog!.show(max: 100, msg: 'Espere un momento...');
    isEnable = false;
      ////-----------------actualizar----------------
    User myUser = User(
      id: user!.id,
      name: name,
      lastname: lastName,
      phone: phone,
      image: user!.image,
    );

    Stream? stream = await usersProvider.update(myUser, imageFile);
    stream?.listen((res) async {
        _progressDialog!.update(value: 50, msg: 'Procesando...');

        _progressDialog!.close();

          // Manejar la respuesta del servidor
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
          MySnackBar.successSnackBar( title: 'Actualización Exitosa', message: '${responseApi.message}');
      
      if (responseApi.success!) {
        user = await usersProvider.getById(user!.id); // obtener el usuario actualizado
        _sharedPref.save('user', user!.toJson());
        Get.offAllNamed('cliente/products/list');
       
      } else {
        isEnable = true;
      }
    });
  }

///////////-----------------IMAGEN----------------
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

////////{-----------------SHOW ALERT DIALOG----------------}
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

/////////-----------------BACK----------------
  void back() {
    Navigator.pop(context!);
  }
}
