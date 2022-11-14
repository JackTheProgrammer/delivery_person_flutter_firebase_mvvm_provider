// ignore_for_file: prefer_collection_literals

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '/model/delivery.dart';
import '/view/widgets/delivery_widget.dart';
import '/viewmodel/database_viewmodel.dart';
import '/viewmodel/location_viewmodel.dart';

class OrdersDetails extends StatefulWidget {
  const OrdersDetails({Key? key}) : super(key: key);

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kPakistan = const CameraPosition(
    target: LatLng(30.3753, 69.3451),
    zoom: 14.4746,
  );

  List<Marker> markersFromDocs(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    return docs.map(
      (documentSnapshot) {
        var delivery = Delivery.fromDocSnapshot(documentSnapshot);
        return Marker(
          markerId: MarkerId(documentSnapshot.id),
          position: LatLng(
            delivery.destination.latitude,
            delivery.destination.longitude,
          ),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => DeliveryWidget(
                item: delivery.item,
              ),
            );
          },
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseViewModel>(
      builder: (context, db, _) => FutureBuilder(
        future: db.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<LocationViewModel>(
              builder: (context, location, _) {
                return GoogleMap(
                  initialCameraPosition: _kPakistan,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  markers: Set.of(
                    [
                      ...markersFromDocs(snapshot.data!.docs),
                      ...location.getDelivererMarker(),
                    ],
                  ),
                  onMapCreated: (controller) {
                    _controller.complete(controller);
                  },
                  polylines: location.polylines(snapshot.data!.docs),
                );
              },
            );
          }

          return const Text(
            "No data",
          );
        },
      ),
    );
  }
}
