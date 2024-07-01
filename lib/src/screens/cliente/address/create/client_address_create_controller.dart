import 'package:delivery_autonoma/src/models/address.dart';
import 'package:delivery_autonoma/src/models/response_api.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/address_provider.dart';
import 'package:delivery_autonoma/src/screens/cliente/address/maps/client_address_maps_page.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientAddressCreateController {
  BuildContext? context;
  Function? refresh;

  TextEditingController refPointController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();

  Map<String, dynamic> refPoint = {};

  final AddressProvider _addressProvider = AddressProvider();
  User? user;
  final SharedPref _sharedPref = SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
<<<<<<< HEAD
    // ignore: use_build_context_synchronously
=======
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
    _addressProvider.init(context, user!);
  }

  void createAddress() async {
    String addressName = addressController.text;
    String neighborhood = neighborhoodController.text;
    double lat = refPoint['lat'] ?? 0;
    double lng = refPoint['lng'] ?? 0;

<<<<<<< HEAD
=======
    // Imprimir valores de los TextField
    print('Address Name: $addressName');
    print('Neighborhood: $neighborhood');
    print('Lat: $lat, Lng: $lng');
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db

    if (addressName.isEmpty || neighborhood.isEmpty || lat == 0 || lng == 0) {
      MySnackBar.warningSnackBar(
          title: 'Campos vacios', message: 'Por favor llene todos los campos');
      return;
    }

    var address = Address(
        address: addressName,
        neighborhood: neighborhood,
        lat: lat,
        lng: lng,
        idUser: user!.id
        );

    ResponseApi? responseApi = await _addressProvider.create(address);
    if (responseApi!.success!) {
      address.id = responseApi.data;
      _sharedPref.save('address', address);

      MySnackBar.successSnackBar(
          title: 'Direccion creada', message: 'Direccion creada correctamente');

      Navigator.pop(context!, true);
    } else {
      MySnackBar.errorSnackBar(title: 'Error', message: responseApi.message!);
    }
    refresh!();
  }

  void openMap() async {
    refPoint = await showMaterialModalBottomSheet(
          context: context!,
          isDismissible: false,
          enableDrag: false,
          builder: (context) => const ClientAddressMapsPage(),
        ) ??
        {};

    refPointController.text = refPoint['address'] ??
        ''; // Asignar una cadena vacía si refPoint['address'] es nulo
    refresh!();
  }
}
