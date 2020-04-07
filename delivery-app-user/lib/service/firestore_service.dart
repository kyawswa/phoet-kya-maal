import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_bloc/model/models.dart';

class FirestoreService {
  final Firestore firestore = Firestore.instance;

  Stream<QuerySnapshot> getOrders([String userId]) => firestore
      .collection('orders')
      // .where(Order.FIELD_ID, isEqualTo: userId)
      .snapshots();
}
