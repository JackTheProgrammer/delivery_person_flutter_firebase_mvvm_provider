import 'package:flutter/material.dart';

class OrderPathScreen extends StatefulWidget {
  const OrderPathScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderPathScreen> createState() => _OrderPathScreenState();
}

class _OrderPathScreenState extends State<OrderPathScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            "I am a center",
          ),
        ),
      ),
    );
  }
}
