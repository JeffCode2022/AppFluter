import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/shared_pref.dart';

class ClientProductsDetailController extends GetxController {
  BuildContext? context;
  Function? refreshFunction;
  Product? product;
  int counter = 1;
  double productPrice = 0.0;

  List<Product> selectedProducts = [];

  final SharedPref _sharedPref = SharedPref();

  final TextEditingController commentController = TextEditingController();

  Future init(BuildContext context, Function refresh, Product product) async {
    this.context = context;
    refreshFunction = refresh;
    this.product = product;
    productPrice = product.price!;
    selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList();
      for (var p in selectedProducts) {
        // ignore: avoid_print
        print('Producto seleccionado: ${p.toJson()}');
      }
    

    refreshFunction!();
  }

  void addToBag() {
    int index = selectedProducts.indexWhere((p) => p.id == product!.id);

    if(commentController.text.isNotEmpty){
      MySnackBar.warningSnackBar(title: 'Comentario', message: 'agrega un comentario');

    }

    if (index == -1) {
      // PRODUCTOS SELECCIONADOS NO EXISTE ESE PRODUCTO
      if (product!.quantity == null) {
        product!.quantity = 1;
      }

      selectedProducts.add(product!);
    } else {
      selectedProducts[index].quantity = counter;
    }

    _sharedPref.save('order', selectedProducts);
    MySnackBar.successSnackBar(
        title: 'Producto agregado', message: 'Producto agregado al carrito');
    // ignore: avoid_print
    print('Producto agregado al carrito${product!.toJson()}');
    print('Productos seleccionados: ${selectedProducts.length}');
    refreshFunction!();
    navigator?.popAndPushNamed('cliente/products/list');
  }

  void addProduct() {
    counter++;
    productPrice = product!.price! * counter;
    product?.quantity = counter;
    refreshFunction!();
  }

  void removeProduct() {
    if (counter > 1) {
      counter--;
      productPrice = product!.price! * counter;
      product?.quantity = counter;
      refreshFunction!();
      
    }
  }

  
}
