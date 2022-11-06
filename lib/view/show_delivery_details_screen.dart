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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Consumer<AuthViewModel>(
          builder: (context, auth, _) {
            return Scaffold(
              appBar: AppBar(
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      text: "1",
                    ),
                    Tab(
                      text: "2",
                    ),
                  ],
                ),
              ),
              body: const TabBarView(
                children: [
                  OrdersDetails(),
                  Text("Data 2"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
