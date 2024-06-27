import 'dart:async';
import 'package:delivery_autonoma/src/api/enviroment.dart';
import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/models/response_api.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/orders_provider.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:url_launcher/url_launcher.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DeliveryOrdersMapsController {
  BuildContext? context;
  Function? refresh;
  Position? position;

  String? addressName;
  LatLng? addressLatLng;
  StreamSubscription? positionStream;

  double? _distanceBetween;
  bool isClose = false;

  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(-12.1766431, -76.9330599),
    zoom: 13,
  );

  final Completer<GoogleMapController> _mapController = Completer();

  BitmapDescriptor? deliveryMarker;
  BitmapDescriptor? homeMarker;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Order? order = Order();

  Set<Polyline> polylines = {};
  List<LatLng> points = [];
  final OrdersProvider _ordersProvider = OrdersProvider();
  SharedPref sharedPref = SharedPref();
  User user = User();

  IO.Socket? socket;

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    order = Order.fromJson(
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>);
    deliveryMarker = await createMarkerFromAsset('assets/img/delivery2.png');
    homeMarker = await createMarkerFromAsset('assets/img/icons8-home-94.png');

    socket = IO.io(
        'http://${Environment.API_DELIVERY}/orders/delivery', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
    socket!.connect();

    user = User.fromJson(await sharedPref.read('user'));
    _ordersProvider.init(context, user);

    checkGPS();
    refresh();
  }

  Future<void> setPolylines(LatLng from, LatLng to) async {
    PointLatLng pointFrom = PointLatLng(from.latitude, from.longitude);
    PointLatLng pointTo = PointLatLng(to.latitude, to.longitude);
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        Environment.API_KEY_MAPS, pointFrom, pointTo);

    if (result.points.isNotEmpty) {
      points.clear();
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
  }

  void saveLocation() async {
    order!.lat = position!.latitude;
    order!.lng = position!.longitude;
    await _ordersProvider.updateLatLng(order!);
    print('Ubicación guardada');
  }

  void emitPosition() {
    socket!.emit('position', {
      'id_order': order!.id,
      'lat': position!.latitude,
      'lng': position!.longitude,
    });
  }

  void isCloseToDeliveryPosition() {
    _distanceBetween = Geolocator.distanceBetween(
      position!.latitude,
      position!.longitude,
      order!.address!.lat!,
      order!.address!.lng!,
    );

    print('-------- DIOSTANCIA ${_distanceBetween} ----------');

    if (_distanceBetween! <= 200 && !isClose) {
      isClose = true;
    }
  }

  Future<BitmapDescriptor> createMarkerFromAsset(String path) async {
    ImageConfiguration configuration = const ImageConfiguration();
    return await BitmapDescriptor.fromAssetImage(configuration, path);
  }

  void addMarker(String markerId, double lat, double lng, String title,
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

  void selectRefPoint() {
    Map<String, dynamic> data = {
      'address': addressName,
      'lat': addressLatLng!.latitude,
      'lng': addressLatLng!.longitude,
    };
    Navigator.of(context!).pop(data);
  }

  void updateToDelivered() async {
    if (_distanceBetween != null && _distanceBetween! <= 200) {
      ResponseApi? responseApi =
          await _ordersProvider.updateToDelivered(order!);
      if (responseApi != null && responseApi.success!) {
        MySnackBar.successSnackBar(
            title: 'Pedido entregado',
            message: 'El pedido se ha entregado correctamente');
        Navigator.pushNamedAndRemoveUntil(
            context!, 'delivery/orders/list', (route) => false);
      }
    } else {
      MySnackBar.errorSnackBar(
          title: 'Error',
          message:
              'No puedes entregar el pedido si no estás cerca del destino');
    }
  }

  Future<void> setLocationDraggableInfo() async {
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
    var url = 'waze://?ll=${order?.address?.lat},${order?.address?.lng}';
    var fallbackUrl =
        'https://waze.com/ul?ll=${order?.address?.lat},${order?.address?.lng}&navigate=yes';
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  void launchGoogleMaps() async {
    var url =
        'google.navigation:q=${order?.address?.lat},${order?.address?.lng}';
    var fallbackUrl =
        'https://www.google.com/maps/search/?api=1&query=${order?.address?.lat},${order?.address?.lng}';
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]');
    _mapController.complete(controller);
  }

  void dispose() {
    positionStream?.cancel();
    socket?.disconnect();
  }

  void updateLocation() async {
    try {
      await _determinePosition();
      position = await Geolocator.getLastKnownPosition();
      saveLocation();
      if (position != null) {
        animateCameraToPosition(position!.latitude, position!.longitude);
        addMarker(
          'myLocation',
          position!.latitude,
          position!.longitude,
          'Mi ubicación',
          'Ubicación actual',
          deliveryMarker!,
        );
        addMarker(
          'Home',
          order!.address!.lat!,
          order!.address!.lng!,
          'Lugar de entrega',
          'Dirección de entrega',
          homeMarker!,
        );

        LatLng from = LatLng(position!.latitude, position!.longitude);
        LatLng to = LatLng(order!.address!.lat!, order!.address!.lng!);

        setPolylines(from, to);

        positionStream = Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
          ),
        ).listen((Position position) {
          this.position = position;

          emitPosition();

          addMarker('delivery', position.latitude, position.longitude,
              'Tu posición', '', deliveryMarker!);

          animateCameraToPosition(position.latitude, position.longitude);
          isCloseToDeliveryPosition();

          refresh!();
        });

        refresh!();
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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

  Future<void> animateCameraToPosition(double lat, double lng) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 15),
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
    launch("tel://${order!.client!.phone}");
  }
}
