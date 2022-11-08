import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '/model/delivery.dart';
import '/view/widgets/delivery_widget.dart';
import '../../viewmodel/database_viewmodel.dart';

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
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseViewModel>(
      builder: (context, db, _) => FutureBuilder(
        future: db.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var delivery = Delivery.fromDocSnapshot(snapshot.data!.docs[0]);

            return GoogleMap(
              initialCameraPosition: _kPakistan,
              markers: Set.of(
                snapshot.data!.docs
                    .map(
                      (documentSnapshot) => Marker(
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
                      ),
                    )
                    .toList(),
              ),
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
