import 'package:cloud_firestore/cloud_firestore.dart'
    show QueryDocumentSnapshot, GeoPoint;
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart'
    show LocationPermission, Geolocator, Position;
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show LatLng, Polyline, PolylineId, Marker, MarkerId, BitmapDescriptor;

import '/core/google_map_config.dart';
import '/model/delivery.dart';

class LocationService {
  final List<LatLng> _polylineCoordinates = <LatLng>[];
  final List<Marker> _markerOfDelivererLocation = <Marker>[];

  PolylinePoints polylinePoints = PolylinePoints();

  Future<Position> _getDelivererPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _addMarker() async {
    MarkerId markerId = const MarkerId("deliverer");
    var position = await _getDelivererPosition();
    _markerOfDelivererLocation.add(
      Marker(
        markerId: markerId,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen,
        ),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
      ),
    );
  }

  List<Marker> getDelivererLocationMarker() {
    _addMarker();
    return _markerOfDelivererLocation;
  }

  void _createPolylineCoordinates(GeoPoint destination) async {
    var position = await _getDelivererPosition();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      YOUR_MAP_API_KEY,
      PointLatLng(
        position.latitude,
        position.longitude,
      ),
      PointLatLng(
        destination.latitude,
        destination.longitude,
      ),
    );

    if (result.points.isNotEmpty) {
      for (var element in result.points) {
        _polylineCoordinates.add(
          LatLng(
            element.latitude,
            element.longitude,
          ),
        );
      }
    }
  }

  Set<Polyline> fetchAllPolylines(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    List<Polyline> polylinesList = docs.map(
      (documentSnapshot) {
        var delivery = Delivery.fromDocSnapshot(documentSnapshot);
        _createPolylineCoordinates(delivery.destination);
        return Polyline(
          polylineId: const PolylineId("deliverer"),
          points: _polylineCoordinates,
          color: Colors.orange,
        );
      },
    ).toList();

    return Set<Polyline>.of(polylinesList);
  }
}
