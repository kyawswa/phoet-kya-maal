import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_bloc/models.dart';

class OrderService{
  final Firestore _firestore = Firestore.instance;

  Future<void> processOrder(String orderId, OrderState status) async{
      await _firestore.collection(Order.COLLECTION_NAME).document(orderId).updateData({ Order.FIELD_STATUS: status.toString() });
  }

  Future<List<Map<String, dynamic>>> fetchOrdersAssignedAsMap(String accountId) async{
      QuerySnapshot snapshot = await _firestore.collection(Order.COLLECTION_NAME).where("${Order.FIELD_DELIVERY_PERSON}.${User.FIELD_ID}", isEqualTo: accountId).where(Order.FIELD_STATUS, isEqualTo: OrderState.PENDING.toString()).getDocuments();
      List<Map<String, dynamic>> resultOrderMapList=[];
      snapshot.documents.forEach((element) {
        Map<String, dynamic> map = element.data;
        map[Order.FIELD_ID] = element.documentID;
        resultOrderMapList.add(map);
      });
      return resultOrderMapList;
  }

  Future<List<Order>> fetchOrderAssigned(String accountId) async {
    List<Order> orderList = [];
    List<Map<String, dynamic>> orderMapList = await fetchOrdersAssignedAsMap(accountId);
    orderMapList.forEach((element) {
      orderList.add(Order.fromMap(element));
    });
    return orderList;
  }

}