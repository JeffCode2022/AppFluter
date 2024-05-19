import 'package:delivery_autonoma/src/models/category.dart';
import 'package:delivery_autonoma/src/models/response_api.dart';
import 'package:delivery_autonoma/src/provider/categories_provider.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/my_snackbar.dart';
import '../../../../models/user.dart';

class RestaurantCategoriesCreateController extends GetxController {
  BuildContext? context;
  Function? refreshMethod;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final CategoriesProvider _categoriesProvider = CategoriesProvider();
  User? user;
  final SharedPref sharedPref = SharedPref();

  Future init(BuildContext context, Function refreshMethod) async {
    this.context = context;
    this.refreshMethod = refreshMethod;
    user = User.fromJson(await sharedPref.read('user'));
    // ignore: use_build_context_synchronously
    _categoriesProvider.init(context, user!);
  }

  void createCategory() async {
    String name = nameController.text.trim();
    String description = descriptionController.text.trim();

    if (name.isEmpty || description.isEmpty) {
      MySnackBar.warningSnackBar(
          title: 'Campos vacíos', message: 'Llena todos los campos');
      return;
    }

    Category category = Category(name: name, description: description);

    ResponseApi? responseApi = await _categoriesProvider.create(category);
    MySnackBar.successSnackBar(
        title: 'Categoría creada',
        message: 'La categoría se ha creado correctamente');

    if (responseApi!.success!) {
      nameController.text = '';
      descriptionController.text = '';
    }
  }
}
