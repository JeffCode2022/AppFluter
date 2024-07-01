import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
<<<<<<< HEAD
import 'package:location/location.dart' as location;
=======
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db

class ClientAddressMapsController {
  BuildContext? context;

  Function? refresh;
  Position? position;

<<<<<<< HEAD
  String? addressName;
  LatLng? addressLatLng;
=======
  String? addressName ;
  LatLng? addressLatLng ;
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db

  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(-12.1766431, -76.9330599),
    zoom: 15,
  );

  final Completer<GoogleMapController> _mapController = Completer();

<<<<<<< HEAD

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    checkGPS();
=======
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // checkGPS();
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db

    refresh();
  }

  void selectRefPoint() {
<<<<<<< HEAD
    Map<String, dynamic> data = {
      'address': addressName,
      'lat': addressLatLng!.latitude,
      'lng': addressLatLng!.longitude,
    };
    Navigator.of(context!).pop(data);
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
=======
      Map<String, dynamic> data = {
        'address': addressName,
        'lat': addressLatLng!.latitude,
        'lng': addressLatLng!.longitude,
      };
      Navigator.of(context!).pop(data);
  }

  Future<Null> setLocationDraggableInfo() async {
    // ignore: unnecessary_null_comparison
    if (initialPosition != null) {
      double lat = initialPosition.target.latitude;
      double lng = initialPosition.target.longitude;

      List<Placemark> address = await placemarkFromCoordinates(lat, lng);

      // ignore: unnecessary_null_comparison
      if (address != null && address.isNotEmpty) {
        // ignore: prefer_is_empty
        if (address.length > 0) {
          String street = address[0].thoroughfare ?? '';
          String direction = address[0].subThoroughfare ?? '';
          String city = address[0].locality ?? '';
          String deparment = address[0].administrativeArea ?? '';
          String country = address[0].country ?? '';

          addressName = '$street $direction, $city, $deparment, $country';
          addressLatLng = LatLng(lat, lng);

          refresh!();
        }
      }
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
    }
  }

  void onMapCreated(GoogleMapController controller) {
<<<<<<< HEAD
    // ignore: deprecated_member_use
    controller.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]');
=======
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
    _mapController.complete(controller);
  }
  //////////////////////////  UPDATE LOCATION  //////////////////////////

  void updatelocation() async {
    try {
      await _determinePosition();
      position = await Geolocator.getLastKnownPosition();
      inamteCameraToPosition(position!.latitude, position!.longitude);
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }
  //////////////////////////  CHECK GPS  //////////////////////////

<<<<<<< HEAD
  void checkGPS() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
          updatelocation();
         } else {
           bool locationGPS = await location.Location().requestService();
          if (locationGPS) {
             updatelocation();
           }
    }
  }

  
=======
  // void checkGPS() async {
  //   bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

  //   if (!isLocationEnabled) {
  //     updatelocation();
  //   } else {
  //     bool locationGPS = await location.Location().requestService();
  //     if (locationGPS) {
  //       updatelocation();
  //     }
  //   }
  // }

>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
//////////////////////////  CAMERA TO POSITION  //////////////////////////
  Future inamteCameraToPosition(double lat, double lng) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 15, bearing: 0),
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
}
