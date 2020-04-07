import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
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

  final String id;
  final User user;
  final User deliveryPerson;
  final Timestamp orderTimeStamp;
  final Timestamp deliverTime;
  final Timestamp estimatedTime;
  final String status;
  final List<Item> orderItems;

  Order({
    this.id,
    this.user,
    this.deliveryPerson,
    this.orderTimeStamp,
    this.deliverTime,
    this.estimatedTime,
    this.status,
    this.orderItems,
  });

  // Order.fromMap(Map<String, dynamic> inputMap)
  //     : deliveryPerson = User(id: inputMap[FIELD_DELIVERY_PERSON_ID]),
  //       estimatedTime = inputMap[FIELD_ESTIMATED],
  //       orderTimeStamp = inputMap[FIELD_ORDER_TIMESTAMP],
  //       deliverTime = inputMap[FIELD_DELIVERY_TIME],
  //       status = inputMap[FIELD_STATE],
  //       orderItems = Item.toList(inputMap[FIELD_ORDER_ITEMS]),
  //       user = User.fromMap(inputMap[FIELD_USER]);

  Order.fromMapWithID(DocumentSnapshot document)
      : id = document.documentID,
        deliveryPerson = User(id: document.data[FIELD_DELIVERY_PERSON_ID]),
        estimatedTime = document.data[FIELD_ESTIMATED],
        orderTimeStamp = document.data[FIELD_ORDER_TIMESTAMP],
        deliverTime = document.data[FIELD_DELIVERY_TIME],
        status = document.data[FIELD_STATE],
        orderItems = Item.toList(document.data[FIELD_ORDER_ITEMS]),
        user = User.fromMap(document.data[FIELD_USER]);

  @override
  String toString() {
    return 'Order{id: $id, user: $user, deliveryPerson: $deliveryPerson, orderTimeStamp: $orderTimeStamp, deliverTime: $deliverTime, estimatedTime: $estimatedTime, status: $status, orderItems: $orderItems}';
  }
}

enum OrderStatus { PENDING, ACCEPT, REJECT, CANCELLED, DELIVERED, ASSIGN }

extension ShortString on OrderStatus {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
