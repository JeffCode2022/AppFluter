import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddressMapsController {
  BuildContext? context;

  Function? refresh;
  Position? position;

  String? addressName ;
  LatLng? addressLatLng ;

  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(-12.1766431, -76.9330599),
    zoom: 15,
  );

  final Completer<GoogleMapController> _mapController = Completer();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // checkGPS();

    refresh();
  }

  void selectRefPoint() {
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
    }
  }

  void onMapCreated(GoogleMapController controller) {
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
