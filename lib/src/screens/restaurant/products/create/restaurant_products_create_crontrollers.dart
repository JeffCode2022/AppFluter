import 'dart:convert';
import 'dart:io';

import 'package:delivery_autonoma/src/models/category.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/models/response_api.dart';
import 'package:delivery_autonoma/src/provider/categories_provider.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../../../../../utils/constants/my_snackbar.dart';
import '../../../../models/user.dart';
import '../../../../provider/products_provider.dart';

class RestaurantProductsCreateController extends GetxController {
  BuildContext? context;
  Function? refreshMethod;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final MoneyMaskedTextController priceController = MoneyMaskedTextController();

  final CategoriesProvider _categoriesProvider = CategoriesProvider();
  final ProductsProvider _productsProvider = ProductsProvider();

  User? user;
  final SharedPref sharedPref = SharedPref();
  List<Category> categories = [];
  String? idCategory;

  ///imagenes
  PickedFile? pickedFile;
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  ProgressDialog? _progressDialog;

  Future init(BuildContext context, Function refreshMethod) async {
    this.context = context;
    this.refreshMethod = refreshMethod;
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await sharedPref.read('user'));
    // ignore: use_build_context_synchronously
    _categoriesProvider.init(context, user!);
    // ignore: use_build_context_synchronously
    _productsProvider.init(context, user!);
    getCategories();
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refreshMethod!();
  }

  void createProduct() async {
    String name = nameController.text.trim();
    String description = descriptionController.text.trim();
    double price = priceController.numberValue;

    if (name.isEmpty || description.isEmpty || price == 0) {
      MySnackBar.warningSnackBar(
          title: 'Campos vacíos', message: 'Llena todos los campos');
      return;
    }
    if (imageFile1 == null || imageFile2 == null || imageFile3 == null) {
      MySnackBar.warningSnackBar(
          title: 'Campos vacíos', message: 'Selecciona las 3 imágenes');
      return;
    }

    if (idCategory == null) {
      MySnackBar.warningSnackBar(
          title: 'Campos vacíos', message: 'Selecciona una categoría');
      return;
    }
    Product product = Product(
        name: name,
        description: description,
        price: price,
        idCategory: int.parse(idCategory!));

    List<File?> images = [];
    images.add(imageFile1);
    images.add(imageFile2);
    images.add(imageFile3);

    _progressDialog!.show(max: 100, msg: 'Creando producto');

    Stream? stream = await _productsProvider.create(product, images);
    stream?.listen((res) {
      _progressDialog?.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      MySnackBar.successSnackBar( title: 'Producto creado', message: responseApi.message!);

          if(responseApi.success!){
            resetValues();
          }
    });

    // ignore: avoid_print
    print('producto formulario ${product.toJson()}');
  }

void resetValues() {
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '0.0';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory = null;
    refreshMethod!();
  }

  Future<void> selectImage(ImageSource source, int numberFile) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      if (numberFile == 1) {
        imageFile1 = File(pickedFile.path);
      } else if (numberFile == 2) {
        imageFile2 = File(pickedFile.path);
      } else {
        imageFile3 = File(pickedFile.path);
      }

      refreshMethod!();
    }
    Navigator.pop(context!);
  }

  void showAlertDialog(int numberFile) {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona tu imagen'),
          actions: [
            ElevatedButton(
                onPressed: () => selectImage(ImageSource.gallery, numberFile),
                child: const Text('Galería')),
            ElevatedButton(
                onPressed: () => selectImage(ImageSource.camera, numberFile),
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
