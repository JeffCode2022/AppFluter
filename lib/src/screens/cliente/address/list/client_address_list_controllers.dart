import 'package:delivery_autonoma/src/models/address.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/address_provider.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientAddressListController {
  BuildContext? context;
  Function? refresh;
  User? user;
  List<Address> address = [];
  final SharedPref _sharedPref = SharedPref();
  final AddressProvider _addressProvider = AddressProvider();
  int? radioValue;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context, user!);
    refresh();
  }

  void handleRadioValueChange(int value) async {
    radioValue = value;
    _sharedPref.save('address', address[value]);

    refresh!();
    print('Valor seleccioonado: $radioValue');
  }

  Future<List<Address>> getAddress() async {
    address = await _addressProvider.getByUser(user!.id!);

    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    int index = address.indexWhere((ad) => ad.id == a.id);

    if (index != -1) {
      radioValue = index;
    }

    print('SE GUARDO LA DIRECCION: ${a.toJson()}');
    return address;
  }

  void addAddress() {
    Navigator.pushNamed(context!, 'client/address/create');
  }

}
