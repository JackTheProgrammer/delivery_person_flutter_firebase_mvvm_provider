import 'package:cloud_firestore/cloud_firestore.dart'
    show QueryDocumentSnapshot;
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show Polyline, Marker;
import '/services/location_service.dart';

class LocationViewModel extends ChangeNotifier {
  final LocationService _locationService = LocationService();

  Set<Polyline> polylines(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    return _locationService.fetchAllPolylines(docs);
  }

  List<Marker> getDelivererMarker() {
    return _locationService.getDelivererLocationMarker();
  }
}
