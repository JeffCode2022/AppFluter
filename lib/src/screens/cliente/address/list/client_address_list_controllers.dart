import 'package:delivery_autonoma/src/models/address.dart';
import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/models/response_api.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/address_provider.dart';
import 'package:delivery_autonoma/src/provider/orders_provider.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientAddressListController {
  BuildContext? context;
  Function? refresh;
<<<<<<< HEAD
  User user = User();
=======
  User? user;
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
  List<Address> address = [];
  final SharedPref _sharedPref = SharedPref();
  final AddressProvider _addressProvider = AddressProvider();
  final OrdersProvider _ordersProvider = OrdersProvider();
  int? radioValue;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
<<<<<<< HEAD
    // ignore: use_build_context_synchronously
    _addressProvider.init(context, user);
    // ignore: use_build_context_synchronously
    _ordersProvider.init(context, user);
=======
    _addressProvider.init(context, user!);
    _ordersProvider.init(context, user!);
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
    refresh();
  }

  void createOrder() async {
<<<<<<< HEAD
    // Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    // List<Product> selectedProducts =
    //     Product.fromJsonList(await _sharedPref.read('order')).toList();

    // Order order = Order(
    //   idClient: user.id,
    //   idAddress: a.id,
    //   products: selectedProducts,
    // );
    // ResponseApi? responseApi = await _ordersProvider.create(order);

    Navigator.pushNamed(context!, 'client/payments/create');
    // ignore: avoid_print
    //print('RESPONSE API: ${responseApi!.toJson()}');
=======
    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    List<Product> selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;

    Order order = Order(
      idClient: user!.id,
      idAddress: a.id,
      products: selectedProducts,
    );
    ResponseApi? responseApi = await _ordersProvider.create(order);
    print('RESPONSE API: ${responseApi!.toJson()}');
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
  }

  void handleRadioValueChange(int value) async {
    radioValue = value;
    _sharedPref.save('address', address[value]);

<<<<<<< HEAD
    refresh!();
    // ignore: avoid_print
    print('Valor seleccioonado: $radioValue');
  }

  Future<List<Address>> getAddress() async {
    address = await _addressProvider.getByUser(user.id);
=======
    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});

    refresh!();
    print('Valor seleccioonado: $a');
  }

  Future<List<Address>> getAddress() async {
    address = await _addressProvider.getByUser(user!.id!);
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db

    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    int index = address.indexWhere((ad) => ad.id == a.id);

    if (index != -1) {
      radioValue = index;
    }
<<<<<<< HEAD
    // ignore: avoid_print
    print('SE GUARDO LA DIRECCION: ${a.toJson()}');

=======

    print('SE GUARDO LA DIRECCION: ${a.toJson()}');
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
    return address;
  }

  void addAddress() async {
<<<<<<< HEAD
    var result = await Navigator.pushNamed(context!, 'client/address/create');
    if (result == true) {
      refresh!();
=======
    var result =
        await Navigator.pushNamed(context!, 'client/address/create') as bool;
    if (result != null) {
      if (result) {
        refresh!();
      }
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
    }
  }
}
