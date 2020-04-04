import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_bloc/model/item.dart';
import 'package:flutter_app_bloc/model/user.dart';

class Order {
  static const COLLECTION_NAME = "orders";
  static const FIELD_ID = "";
  static const FIELD_USER = "user";
  static const FIELD_DELIVERY_PERSON_ID = "delivery_account_id";
  static const FIELD_ORDER_TIMESTAMP = "created_date";
  static const FIELD_CREATED_DATE = "created_date"; // to delete
  static const FIELD_DELIVERY_TIME = "delivery_time";
  static const FIELD_STATE = "state";
  static const FIELD_ESTIMATED = "est";
  static const FIELD_ORDER_ITEMS = "items";

  String id;
  User user;
  User deliveryPerson;
  Timestamp orderTimeStamp;
  Timestamp deliverTime;
  Timestamp estimatedTime;
  String status;
  List<Item> orderItems;

  Order({
    this.id,
    this.user,
    this.deliveryPerson,
    this.orderTimeStamp,
    this.deliverTime,
    this.estimatedTime,
    this.status,
    this.orderItems});

  Order.fromMap(Map<String, dynamic> inputMap) {
    deliveryPerson = User(id: inputMap[FIELD_DELIVERY_PERSON_ID]);
    estimatedTime = inputMap[FIELD_ESTIMATED];
    orderTimeStamp = inputMap[FIELD_ORDER_TIMESTAMP];
    deliverTime = inputMap[FIELD_DELIVERY_TIME];
    status = inputMap[FIELD_STATE];
    orderItems = Item.toList(inputMap[FIELD_ORDER_ITEMS]);
    user = User.fromMap(inputMap[FIELD_USER]);
  }

  Order.fromMapWithID(DocumentSnapshot document) {
    Map<String, dynamic> inputMap = document.data;
    id = document.documentID;
    deliveryPerson = User(id: inputMap[FIELD_DELIVERY_PERSON_ID]);
    estimatedTime = inputMap[FIELD_ESTIMATED];
    orderTimeStamp = inputMap[FIELD_ORDER_TIMESTAMP];
    deliverTime = inputMap[FIELD_DELIVERY_TIME];
    status = inputMap[FIELD_STATE];
    orderItems = Item.toList(inputMap[FIELD_ORDER_ITEMS]);
    user = User.fromMap(inputMap[FIELD_USER]);
  }

  @override
  String toString() {
    return 'Order{id: $id, user: $user, deliveryPerson: $deliveryPerson, orderTimeStamp: $orderTimeStamp, deliverTime: $deliverTime, estimatedTime: $estimatedTime, status: $status, orderItems: $orderItems}';
  }


}

enum OrderState { PENDING, ACCEPT, REJECT, CANCELLED, DELIVERED }

extension ShortString on OrderState {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
