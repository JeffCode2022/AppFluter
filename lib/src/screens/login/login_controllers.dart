import 'package:delivery_autonoma/src/models/response_api.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/users_provider.dart';
import 'package:delivery_autonoma/src/screens/signup/signup.dart';
<<<<<<< HEAD
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:delivery_autonoma/utils/popups/full_screen_loader.dart';
=======
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginControllers {
  BuildContext? context;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider userProvider = UsersProvider();
  final SharedPref _sharedPref = SharedPref();

  Future<void> init(BuildContext context) async {
    this.context = context;
    await userProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    // ignore: avoid_print
    print(user.toJson());

    if (user.sessionToken != null) {

          if(user.roles.length>1){
            Get.offAllNamed('roles');
          }else{
            Get.offAllNamed(user.roles[0].route!);
          }
    }
  }

  void goToSignUp() {
    Get.to(() => const SignUpScreen(), transition: Transition.leftToRight);
  }
void login() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  ResponseApi? responseApi = await userProvider.login(email, password);

  // ignore: avoid_print
  print('respuesta object: $responseApi');
  // ignore: avoid_print
  print('Respuesta success: ${responseApi?.toJson()}');

  if (responseApi?.success ?? false) {
    User user = User.fromJson(responseApi!.data);
    _sharedPref.save('user', user.toJson());

<<<<<<< HEAD

    if (user.roles.length > 1) {
      TFullScreenLoader.openLoadingDialog('Iniciando sesión...', TImages.docerAnimation);
      await Future.delayed(const Duration(seconds: 2));
=======
    if (user.roles.length > 1) {
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
      Get.offAllNamed('roles');
    } else {
      Get.offAllNamed(user.roles[0].route!);
    }
  } else {
    MySnackBar.show(context!, responseApi?.message ?? 'Error desconocido');
  }
}

}
