import 'package:delivery_autonoma/src/screens/cliente/orders/maps/client_orders_maps_controllers.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientOrdersMapsPage extends StatefulWidget {
  const ClientOrdersMapsPage({super.key});

  @override
  State<ClientOrdersMapsPage> createState() => _ClientOrdersMapsPageState();
}

class _ClientOrdersMapsPageState extends State<ClientOrdersMapsPage> {
  final ClientOrdersMapsController _con = ClientOrdersMapsController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _con.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          SafeArea(
            child: SizedBox(
              
              height: MediaQuery.of(context).size.height * 0.63,
              child: _googleMaps(),
            ),
          ),
          SafeArea(
            child: Column(children: [
              const Spacer(),
              _cardOrderInfo()
            ]),
          ),

        ],
      ),
    );
  }

  Widget _googleMaps() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: Set<Marker>.of(_con.markers.values),
      polylines: _con.polylines,
    );
  }


  Widget _cardOrderInfo() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.33,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3))
            ]),
        child: Column(
          children: [
            if (_con.order?.address?.neighborhood != null)
              _listTileAddress(
                _con.order!.address!.neighborhood!,
                'Distrito:',
                Icons.my_location,
              ),
            if (_con.order?.address != null)
              _listTileAddress(
                _con.order?.address!.address ?? '',
                'Direccion:',
                Icons.location_on,
              ),
            Divider(
              color: Colors.grey[400],
              endIndent: 30,
              indent: 30,
            ),
            _clientInfo(),
          ],
        ));
  }

  Widget _clientInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Row(
        children: [
          SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundImage: _con.order?.client?.image != null
                    ? NetworkImage(_con.order!.client!.image!)
                    : const AssetImage(TImages.defaultImage) as ImageProvider,
              )),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              '${_con.order?.client?.name ?? ''} ${_con.order?.client?.lastname ?? ''}',
              style: const TextStyle(color: MyColors.darkerGrey, fontSize: 16),
              maxLines: 1,
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.grey[200]),
            child: IconButton(
              onPressed: (){    
              },
              icon: const Icon(
                Icons.phone,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _listTileAddress(String subtitle, String title, IconData iconData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: MyColors.dark,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: MyColors.darkerGrey, fontSize: 17),
        ),
        trailing: Icon(iconData),
      ),
    );
  }

  void refresh() {
    if (!mounted) return;
    setState(() {});
  }
}
