import 'package:flutter_app_bloc/model/item.dart';
import 'package:flutter_app_bloc/model/user.dart';

class Order {
  String id;
  DateTime createdDate;
  String deliveryAccountId;
  DateTime deliveryTime;
  DateTime est;
  List<Item> items;
  User user;

  Order({
    this.id,
    this.createdDate,
    this.deliveryAccountId,
    this.deliveryTime,
    this.est,
    this.items,
    this.user
  });
}
