import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '/model/delivery.dart';
import '/view/widgets/delivery_widget.dart';
import '../../viewmodel/database_viewmodel.dart';

class OrdersDetails extends StatefulWidget {
  const OrdersDetails({Key? key}) : super(key: key);

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseViewModel>(
      builder: (context, db, _) {
        return FutureBuilder(
          future: db.getOrders(),
          builder: (context, snapshot) {
            return SfMaps(
              layers: [
                MapShapeLayer(
                  initialMarkersCount: snapshot.data!.docs.length,
                  source: const MapShapeSource.asset("asset/world_map.json"),
                  markerBuilder: (context, index) {
                    var delivery =
                        Delivery.fromDocSnapshot(snapshot.data!.docs[index]);
                    return MapMarker(
                      latitude: delivery.destination.latitude,
                      longitude: delivery.destination.longitude,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => DeliveryWidget(
                              item: delivery.item,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
