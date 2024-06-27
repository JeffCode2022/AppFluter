import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLinePoints {
  Future<dynamic> getRouteBetweenCoordinates({
    required String googleApiKey,
    required PointLatLng origin,
    required PointLatLng destination,
    List<PointLatLng> wayPoints = const [],
    bool avoidHighways = false,
    bool avoidTolls = false,
    bool avoidFerries = true,
    bool optimizeWaypoints = false,
  }) async {
    assert(googleApiKey.isNotEmpty, "Google API Key cannot be empty");

    try {
      var polylineWayPoints = wayPoints
          .map((point) => PolylineWayPoint(
              location: LatLng(point.latitude, point.longitude).toString()))
          .toList();

      var result = await NetworkUtil().getRouteBetweenCoordinates(
        request: PolylineRequest(
          apiKey: googleApiKey,
          origin: origin,
          destination: destination,
          mode: TravelMode.driving,
          wayPoints: polylineWayPoints,
          avoidHighways: avoidHighways,
          avoidTolls: avoidTolls,
          avoidFerries: avoidFerries,
          alternatives: false,
          optimizeWaypoints: optimizeWaypoints,
        ),
      );

      return result.isNotEmpty
          ? result[0]
          : PolylineResult(errorMessage: "No result found");
    } catch (e) {
      // Print detailed error message
      // ignore: avoid_print
      print('Error: $e');
      return PolylineResult(errorMessage: "Unable to get route: $e");
    }
  }
}
