import 'package:flutter/material.dart';
import '/ui/widgets/orders_details.dart';

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
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
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
