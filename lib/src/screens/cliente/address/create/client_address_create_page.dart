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
<<<<<<< HEAD
          title: Text(
            'Crear dirección',
            style: TextStyle(fontSize: 20),
          ),
=======
          title: Text('Crear dirección', style: TextStyle(color: Colors.white)),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
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
<<<<<<< HEAD
      child: TextField(
=======
      child:  TextField(
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
        controller: _con.addressController,
        decoration: const InputDecoration(
            labelText: 'Direccion',
            suffixIcon: Icon(
              Iconsax.global_search,
<<<<<<< HEAD
              color: MyColors.primary,
=======
              color: MyColors.primaryColor,
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
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
<<<<<<< HEAD
              color: MyColors.primary,
=======
              color: MyColors.primaryColor,
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
            )),
      ),
    );
  }

  Widget _textFieldNeighborhood() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
<<<<<<< HEAD
      child: TextField(
=======
      child:  TextField(
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
        controller: _con.neighborhoodController,
        decoration: const InputDecoration(
            labelText: 'Distrito',
            suffixIcon: Icon(
              Icons.maps_home_work,
<<<<<<< HEAD
              color: MyColors.primary,
=======
              color: MyColors.primaryColor,
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
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
<<<<<<< HEAD
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 60, left: 30, right: 30, top: 40),
      child: ElevatedButton(
        onPressed: _con.createAddress,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: MyColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          elevation: 5,
        ),
        child: const Text(
          'Crear dirección',
        ),
=======
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
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
      ),
    );
  }

  void refresh() {
<<<<<<< HEAD
    if (mounted) return;
=======
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
    setState(() {});
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
