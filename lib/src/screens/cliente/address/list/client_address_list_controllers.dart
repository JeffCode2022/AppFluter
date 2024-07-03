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
  User user = User();
  List<Address> address = [];
  final SharedPref _sharedPref = SharedPref();
  final AddressProvider _addressProvider = AddressProvider();
  final OrdersProvider _ordersProvider = OrdersProvider();
  int? radioValue;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    // ignore: use_build_context_synchronously
    _addressProvider.init(context, user);
    // ignore: use_build_context_synchronously
    _ordersProvider.init(context, user);
    refresh();
  }

  void createOrder() async {
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
  }

  void handleRadioValueChange(int value) async {
    radioValue = value;
    _sharedPref.save('address', address[value]);

    refresh!();
    // ignore: avoid_print
    print('Valor seleccioonado: $radioValue');
  }

  Future<List<Address>> getAddress() async {
    address = await _addressProvider.getByUser(user.id);

    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    int index = address.indexWhere((ad) => ad.id == a.id);

    if (index != -1) {
      radioValue = index;
    }
    // ignore: avoid_print
    print('SE GUARDO LA DIRECCION: ${a.toJson()}');

    return address;
  }

  void addAddress() async {
    var result = await Navigator.pushNamed(context!, 'client/address/create');
    if (result == true) {
      refresh!();
    }
  }
}
