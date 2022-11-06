import 'package:cloud_firestore/cloud_firestore.dart'
    show QuerySnapshot, DocumentSnapshot;
import 'package:flutter/material.dart';

import '/services/cloud_firestore_services.dart';

class DatabaseViewModel extends ChangeNotifier {
  final CloudFirestoreStorageService _firestoreStorageService =
      CloudFirestoreStorageService();

  Future<QuerySnapshot<Map<String, dynamic>>> getDelivered() async {
    return await _firestoreStorageService.getAllDelivered();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDeliveredDetails(
    String deliveredDocID,
  ) async {
    return await _firestoreStorageService.getDeliveredDetails(deliveredDocID);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getOrders() async {
    return await _firestoreStorageService.getAllOrders();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getOrderDetails(
    String orderDocID,
  ) async {
    return await _firestoreStorageService.getOrderDetails(orderDocID);
  }
}
