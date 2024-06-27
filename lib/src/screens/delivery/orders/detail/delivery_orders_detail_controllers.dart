import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/models/response_api.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/orders_provider.dart';
import 'package:delivery_autonoma/src/provider/users_provider.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';

class DeliveryOrderDetailController {
  BuildContext? context;
  Function? refresh;

  Product? product;

  int counter = 1;
  double? productPrice;

  final SharedPref _sharedPref = SharedPref();
  final UsersProvider _usersProvider = UsersProvider();
  final OrdersProvider _ordersProvider = OrdersProvider();

  double total = 0;
  User? user;
  Order? order;
  List<User> users = [];
  String? idDelivery;

  Future init(BuildContext context, Function refresh, Order order) async {
    this.context = context;
    this.refresh = refresh;
    this.order = order;
    user = User.fromJson(await _sharedPref.read('user'));
    // ignore: use_build_context_synchronously
    _usersProvider.init(context, sessionUser: user!);
    // ignore: use_build_context_synchronously
    _ordersProvider.init(context, user!);
    getTotal();
    getUsers();
    refresh();
  }

  void updateOrder() async {
    ResponseApi? responseApi = await _ordersProvider.updateToOnTheWay(order!);
    if (responseApi!.success!) {
      MySnackBar.successSnackBar(
          title: 'En Camino', message: ' Procesando la ruta para la entrega');
           Navigator.pushNamed(context!, 'delivery/orders/maps', arguments: order?.toJson());
      
    } else {
      MySnackBar.errorSnackBar(title: 'Error', message: responseApi.message!);
    }
  }

  void getUsers() async {
    users = await _usersProvider.getDeliveryMen();
    refresh!();
  }

  void getTotal() {
    total = 0;
    for (var product in order!.products) {
      total = total + (product.price! * product.quantity!);
    }
    refresh!();
  }
  
  


}
