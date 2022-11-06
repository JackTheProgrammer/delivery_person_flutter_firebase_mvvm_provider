import 'package:flutter/material.dart';

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
    );
  }
}
