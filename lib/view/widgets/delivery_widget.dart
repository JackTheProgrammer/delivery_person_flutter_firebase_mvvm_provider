// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/order_path_screen.dart';
import '../viewmodel/location_viewmodel.dart';

class DeliveryWidget extends StatefulWidget {
  final String item;
  const DeliveryWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<DeliveryWidget> createState() => _DeliveryWidgetState();
}

class _DeliveryWidgetState extends State<DeliveryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.item),
      ),
      floatingActionButton: Consumer<LocationViewModel>(
        builder: (context, location, _) {
          return FloatingActionButton(
            child: const Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderPathScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
