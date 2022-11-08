import 'package:delivery_person_app_mvvm/core/color_schema.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/view/widgets/orders_details.dart';
import '/viewmodel/auth_viewmodel.dart';

class ShowDeliveryDetailsScreen extends StatefulWidget {
  const ShowDeliveryDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ShowDeliveryDetailsScreen> createState() =>
      _ShowDeliveryDetailsScreenState();
}

class _ShowDeliveryDetailsScreenState extends State<ShowDeliveryDetailsScreen> {
  List<Widget> scaffoldBody = const <Widget>[
    OrdersDetails(),
    Text("Some random text"),
  ];

  int _index = 0;

  void _onTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: scaffoldBody.elementAt(_index),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining),
              label: "Delivered",
            ),
          ],
          onTap: _onTapped,
        ),
      ),
    );
  }
}
