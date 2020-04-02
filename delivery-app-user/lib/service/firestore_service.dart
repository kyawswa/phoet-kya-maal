import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final Firestore firestore = Firestore.instance;

  Stream<QuerySnapshot> getOrders() =>
      firestore.collection('orders').snapshots();
}
