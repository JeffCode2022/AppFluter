import 'package:delivery_autonoma/src/screens/delivery/orders/maps/delivery_orders_maps_controllers.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryOrdersMapsPage extends StatefulWidget {
  const DeliveryOrdersMapsPage({super.key});

  @override
  State<DeliveryOrdersMapsPage> createState() => _DeliveryOrdersMapsPageState();
}

class _DeliveryOrdersMapsPageState extends State<DeliveryOrdersMapsPage> {
  final DeliveryOrdersMapsController _con = DeliveryOrdersMapsController();

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
              
              height: MediaQuery.of(context).size.height * 0.57,
              child: _googleMaps(),
            ),
          ),
          SafeArea(
            child: Column(children: [
              const Spacer(),
              _cardOrderInfo()
            ]),
          ),
          Positioned(top: 90, left: 17, child: _iconGoogleMaps()),
          Positioned(top: 120, left: 15, child: _iconWaze())
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

  Widget _buttomCenterPosition() {
    return GestureDetector(
        onTap: () {},
        child: Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Card(
              elevation: 5,
              shape: const CircleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.location_searching,
                  color: Colors.black38,
                  size: 40,
                ),
              ),
            )));
  }

  Widget _cardOrderInfo() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
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
            _buttonNext(),
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
              onPressed: _con.call,
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
  Widget _buttonNext() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
      child: ElevatedButton(
        onPressed: _con.updateToDelivered,
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 40,
                alignment: Alignment.center,
                child: const Text(
                  'ENTREGAR PRODUCTO',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 45, top: 4),
                height: 30,
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _iconGoogleMaps() {
    return GestureDetector(
      onTap: _con.launchGoogleMaps,
      child: Image.asset(
        'assets/img/maps.png',
        height: 28,
        width: 28,
      ),
    );
  }

  Widget _iconWaze() {
    return GestureDetector(
      onTap: _con.launchWaze,
      child: Image.asset(
        'assets/img/waze.png',
        height: 35,
        width: 35,
      ),
    );
  }

  void refresh() {
    if (!mounted) return;
    setState(() {});
  }
}
