import 'package:cloud_firestore/cloud_firestore.dart';

class Delivery {
  final GeoPoint destination;
  final String item;

  Delivery({
    required this.destination,
    required this.item,
  });

  factory Delivery.fromDocSnapshot(DocumentSnapshot documentSnapshot) {
    return Delivery(
      destination: documentSnapshot['destination'],
      item: documentSnapshot['item'],
    );
  }
}
