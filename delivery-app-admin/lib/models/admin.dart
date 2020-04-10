import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  static const FIELD_NAME = 'name';
  static const FIELD_CREATED_DATE = 'created_date';
  static const FIELD_DELIVERY_TOWNSHIPS = 'delivery_townships';
  static const FIELD_DIVISION = 'division';
  static const FIELD_PHONE_NUMBER = 'phone_number';
  static const FIELD_ROLE = 'role';
  static const FIELD_ID = 'id';

  final String id;
  final String name;
  final Timestamp createdDate;
  final List<String> phoneNumber;
  final String division;
  final List<String> deliveryTownships;

  static const ROLE = 'ADMIN';

  Admin(
    this.id,
    this.name,
    this.createdDate,
    this.phoneNumber,
    this.division,
    this.deliveryTownships,
  );

  Admin.fromMapWithID(DocumentSnapshot document)
      : this.id = document.data[FIELD_ID],
        this.name = document.data[FIELD_NAME],
        this.createdDate = document.data[FIELD_CREATED_DATE],
        this.phoneNumber = List<String>.from(document.data[FIELD_PHONE_NUMBER]),
        this.division = document.data[FIELD_DIVISION],
        this.deliveryTownships =
            List<String>.from(document.data[FIELD_DELIVERY_TOWNSHIPS]);
}
