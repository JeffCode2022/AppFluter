import 'package:delivery_autonoma/common/widgets/appbar/appbar.dart';
import 'package:delivery_autonoma/src/screens/cliente/address/create/client_address_create_controller.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';

class ClientAddressCreatePage extends StatefulWidget {
  const ClientAddressCreatePage({super.key});

  @override
  State<ClientAddressCreatePage> createState() =>
      _ClientAddressCreatePageState();
}

class _ClientAddressCreatePageState extends State<ClientAddressCreatePage> {
  final ClientAddressCreateController _con = ClientAddressCreateController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TAppBar(
          title: Text('Crear dirección', style: TextStyle(color: Colors.white)),
          showBackArrow: true,
        ),
        body: Column(
          children: [
            _textCompleteData(),
            _textFieldAddress(),
            _textFieldRefPoint(),
            _textFieldNeighborhood(),
            _buttonAccept()
          ],
        ));
  }

  Widget _textFieldAddress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child:  TextField(
        controller: _con.addressController,
        decoration: const InputDecoration(
            labelText: 'Direccion',
            suffixIcon: Icon(
              Iconsax.global_search,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldRefPoint() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.refPointController,
        onTap: _con.openMap,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: const InputDecoration(
            labelText: 'Punto de referencia',
            suffixIcon: Icon(
              Iconsax.map_1,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldNeighborhood() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child:  TextField(
        controller: _con.neighborhoodController,
        decoration: const InputDecoration(
            labelText: 'Distrito',
            suffixIcon: Icon(
              Icons.maps_home_work,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textCompleteData() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: const Text(
        'Completa estos datos',
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buttonAccept() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: ElevatedButton(
        onPressed:_con.createAddress,
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: MyColors.primaryColor),
        child: const Text('CREAR DIRECCION',style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
