import 'package:cloud_firestore/cloud_firestore.dart';


class User{
  static const COLLECTION_NAME="";
  static const FIELD_ID="";
  static const FIELD_NAME="";
  static const FIELD_PHONE="";
  static const FIELD_ADDRESS="";

  String id;
  String name;
  String phoneNo;
  String address;


  User(this.id, this.name, this.phoneNo, this.address);

  User.fromMap(Map<String, dynamic> inputMap){
    id = inputMap[FIELD_ID];
    name = inputMap[FIELD_NAME];
    phoneNo = inputMap[FIELD_PHONE];
    address = inputMap[FIELD_ADDRESS];
  }
}

enum OrderState{
  PENDING, ACCEPT, REJECT, CANCELLED, DELIVERED
}

class Order{
  static const COLLECTION_NAME="";
  static const FIELD_ID="";
  static const FIELD_USER="";
  static const FIELD_DELIVERY_PERSON="";
  static const FIELD_ORDER_TIMESTAMP="";
  static const FIELD_STATUS="";
  static const FIELD_ESTIMATED="";
  static const FIELD_ORDER_ITEMS="";

  String id;
  User user;
  User deliveryPerson;
  Timestamp orderTimeStamp;
  int estimatedTime;
  String status;
  List<Map<String, dynamic>> orderItems;


  Order(this.id, this.user, this.deliveryPerson, this.orderTimeStamp,
      this.estimatedTime, this.status, this.orderItems);

  Order.fromMap(Map<String, dynamic> inputMap){
    id = inputMap[FIELD_ID];
    user = User.fromMap(inputMap[FIELD_USER]);
    orderTimeStamp = inputMap[FIELD_ORDER_TIMESTAMP];
    orderItems = inputMap[FIELD_ORDER_ITEMS];
    deliveryPerson = User.fromMap(inputMap[FIELD_DELIVERY_PERSON]);
    estimatedTime = inputMap[FIELD_ESTIMATED];
    status = inputMap[FIELD_STATUS];
  }

}