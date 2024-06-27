import 'package:delivery_autonoma/src/screens/cliente/address/maps/client_address_maps_controllers.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddressMapsPage extends StatefulWidget {
  const ClientAddressMapsPage({super.key});

  @override
  State<ClientAddressMapsPage> createState() => _ClientAddressMapsPageState();
}

class _ClientAddressMapsPageState extends State<ClientAddressMapsPage> {
  final ClientAddressMapsController _con = ClientAddressMapsController();

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
      appBar: AppBar(
        title: const Text(
          'Selecciona tu dirección',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          _googleMaps(),
          Container(
            alignment: Alignment.center,
            child: _iconMyLocation(),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(bottom: 20, top: 20),
            child: _cardAddress(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: _buttonAccept(),
          )
        ],
      ),
    );
  }

  Widget _cardAddress() {
    return Card(
      color: Colors.grey[500],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text(
          _con.addressName ?? 'Dirección no encontrada',
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _googleMaps() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      onCameraMove: (position) {
        _con.initialPosition = position;
      },
      onCameraIdle: () async {
        await _con.setLocationDraggableInfo();
      },
    );
  }

  Widget _iconMyLocation() {
    return Image.asset(
      'assets/img/my_location.png',
      width: 50,
      height: 50,
    );
  }

Widget _buttonAccept() {
  return Container(
    alignment: Alignment.bottomCenter,
    margin: const EdgeInsets.only(bottom: 60, left: 30, right: 30),
    child: ElevatedButton(
      onPressed: _con.selectRefPoint,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: MyColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 5,
      ),
      child: const Text(
        'Aceptar dirección',
      ),
    ),
  );
}


  void refresh() {
    setState(() {});
  }
}
