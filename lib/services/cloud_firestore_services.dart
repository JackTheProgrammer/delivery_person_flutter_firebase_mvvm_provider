import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class CloudFirestoreStorageService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _userUid = FirebaseAuth.instance.currentUser!.uid;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllDelivered() async {
    return await _firebaseFirestore
        .collection("deliverers")
        .doc(_userUid)
        .collection("delivered")
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDeliveredDetails(
    String deliveredDocID,
  ) async {
    return await _firebaseFirestore
        .collection("deliverers")
        .doc(_userUid)
        .collection("delivered")
        .doc(deliveredDocID)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllOrders() async {
    debugPrint("The uid is: $_userUid");
    return await _firebaseFirestore
        .collection("deliverers")
        .doc(_userUid)
        .collection("orders")
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getOrderDetails(
    String orderDocID,
  ) async {
    return await _firebaseFirestore
        .collection("deliverers")
        .doc(_userUid)
        .collection('orders')
        .doc(orderDocID)
        .get();
  }
}
