// ignore_for_file: unnecessary_null_comparison

import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MySnackBar {
  static void show(BuildContext context, String message) {
    if (context == null) return;

    FocusScope.of(context).requestFocus(FocusNode());
<<<<<<< HEAD
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: THelperFunctions.isDarkMode(Get.context!)
                ? MyColors.primary.withOpacity(0.3)
                : MyColors.primary.withOpacity(0.3),
          ),
          child: Center(
              child: Text(message,
                  style: Theme.of(Get.context!).textTheme.labelLarge)),
        )));
=======
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final snackBar = SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      content: Container(
        decoration: BoxDecoration(
          color: THelperFunctions.isDarkMode(context)
              ? MyColors.primary.withOpacity(0.9)
              : MyColors.primary.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: MyColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
  }

  static void successSnackBar({
    required String title,
    String message = '',
    int duration = 3,
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: MyColors.lightGreen,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.check, color: MyColors.white),
    );
  }

  static void warningSnackBar({
    required String title,
    String message = '',
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: MyColors.white),
    );
  }

  static void errorSnackBar({
    required String title,
    String message = '',
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: MyColors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: MyColors.white),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
