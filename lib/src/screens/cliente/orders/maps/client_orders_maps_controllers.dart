import 'dart:async';
import 'package:delivery_autonoma/src/api/enviroment.dart';
import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/orders_provider.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:url_launcher/url_launcher.dart';

class ClientOrdersMapsController {
  BuildContext? context;

  Function? refresh;
  Position? position;

  String? addressName;
  LatLng? addressLatLng;
  StreamSubscription? positionStream;

  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(-12.1766431, -76.9330599),
    zoom: 15,
  );

  final Completer<GoogleMapController> _mapController = Completer();

  BitmapDescriptor? deliveryMarker;
  BitmapDescriptor? homeMarker;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Order? order = Order();

  Set<Polyline> polylines = {};
  List<LatLng> points = [];
  User user = User();

  final OrdersProvider _ordersProvider = OrdersProvider();
  final SharedPref _sharedPref = SharedPref();

  late double _distanceBetween;
  late IO.Socket socket;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    order = Order.fromJson(
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>);
    deliveryMarker = await createMarkerFromAsset(
        'assets/img/delivery2.png');
    homeMarker = await createMarkerFromAsset('assets/img/home.png');

    socket = IO.io(
        'http://${Environment.API_DELIVERY}/orders/delivery', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
    socket.connect();
    socket.on('position/${order!.id!}', (data) {
      print('DATA EMITIDA: ${data}');

      addMarkert('delivery', data['lat'], data['lng'], 'Tu repartidor', '',
          deliveryMarker!);
    });

    user = User.fromJson(await _sharedPref.read('user'));
    _ordersProvider.init(context, user);
    print('ORDEN: ${order?.toJson()}');

    checkGPS();

  }
    void isCloseToDeliveryPosition() {
    _distanceBetween = Geolocator.distanceBetween(
        position!.latitude,
        position!.longitude,
        order!.address!.lat!,
        order!.address!.lng!
    );

    print('-------- DISTANCIA ${_distanceBetween} ----------');
  }


  ///-----------------  CREATE POLYLINE  -----------------

  Future<void> setPolylines(LatLng from, LatLng to) async {
    PointLatLng pointFrom = PointLatLng(from.latitude, from.longitude);
    PointLatLng pointTo = PointLatLng(to.latitude, to.longitude);
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        Environment.API_KEY_MAPS, pointFrom, pointTo);

    for (PointLatLng point in result.points) {
      points.add(LatLng(point.latitude, point.longitude));
    }

    Polyline polyline = Polyline(
        polylineId: const PolylineId('poly'),
        color: MyColors.primaryColor,
        points: points,
        width: 6);

    polylines.add(polyline);

    refresh!();
  }


  void addMarkert(String markerId, double lat, double lng, String title,
      String content, BitmapDescriptor iconMarker) {
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
      markerId: id,
      icon: iconMarker,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: title, snippet: content),
    );

    markers[id] = marker;
    refresh!();
  }

  ///-----------------  SELECT REFERENCE POINT  -----------------
  void selectRefPoint() {
    Map<String, dynamic> data = {
      'address': addressName,
      'lat': addressLatLng!.latitude,
      'lng': addressLatLng!.longitude,
    };
    Navigator.of(context!).pop(data);
  }
  ///-----------------  CREATE MARKER FROM ASSET  -----------------
  Future<BitmapDescriptor> createMarkerFromAsset(String path) async {
    ImageConfiguration configuration = const ImageConfiguration();
    BitmapDescriptor descriptor =
    await BitmapDescriptor.fromAssetImage(configuration, path);
    return descriptor;
  }


  Future<Null> setLocationDraggableInfo() async {
    double lat = initialPosition.target.latitude;
    double lng = initialPosition.target.longitude;

    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      String street = place.thoroughfare ?? '';
      String direction = place.subThoroughfare ?? '';
      String city = place.locality ?? '';
      String department = place.administrativeArea ?? '';
      String country = place.country ?? '';

      addressName = '$street $direction, $city, $department, $country';
      addressLatLng = LatLng(lat, lng);

      refresh!();
    }
  }

  void launchWaze() async {
    var url =
        'waze://?ll=${order?.address?.lat.toString()},${order?.address?.lng.toString()}';
    var fallbackUrl =
        'https://waze.com/ul?ll=${order?.address?.lat.toString()},${order?.address?.lng.toString()}&navigate=yes';
    try {
      bool launched =
          // ignore: deprecated_member_use
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        // ignore: deprecated_member_use
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      // ignore: deprecated_member_use
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  void launchGoogleMaps() async {
    var url =
        'google.navigation:q=${order?.address?.lat.toString()},${order?.address?.lng.toString()}';
    var fallbackUrl =
        'https://www.google.com/maps/search/?api=1&query=${order?.address?.lat.toString()},${order?.address?.lng.toString()}';
    try {
      bool launched =
          // ignore: deprecated_member_use
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        // ignore: deprecated_member_use
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      // ignore: deprecated_member_use
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  ///-----------------  ON MAP CREATED  -----------------

  void onMapCreated(GoogleMapController controller) {
    // ignore: deprecated_member_use
    controller.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]');
    _mapController.complete(controller);
  }

void dispose() {
    socket.disconnect();
}
  //////////////////////////  UPDATE LOCATION  //////////////////////////

 
  void updateLocation() async {
    try {

      await _determinePosition(); // OBTENER LA POSICION ACTUAL Y TAMBIEN SOLICITAR LOS PERMISOS

 

      inamteCameraToPosition(order!.lat!, order!.lng!);
      addMarkert(
          'delivery',
          order!.lat!,
          order!.lng!,
          'Tu repartidor',
          '',
          deliveryMarker!
      );


      addMarkert(
          'home',
          order!.address!.lat!,
          order!.address!.lng!,
          'Lugar de entrega',
          '',
          homeMarker!
      );

      LatLng from =  LatLng(order!.lat!, order!.lng!);
      LatLng to =  LatLng(order!.address!.lat!, order!.address!.lng!);

      setPolylines(from, to);
      
      refresh!();
    } catch(e) {
      print('Error: $e');
    }
  }


  //////////////////////////  CHECK GPS  //////////////////////////

  void checkGPS() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      updateLocation();
    } else {
      bool locationGPS = await location.Location().requestService();
      if (locationGPS) {
        updateLocation();
      }
    }
  }

//////////////////////////  CAMERA TO POSITION  //////////////////////////
  Future inamteCameraToPosition(double lat, double lng) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 11, bearing: 0),
    ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void call() {
    // ignore: deprecated_member_use
    launch("tel://${order!.client!.phone}");
  }
}
