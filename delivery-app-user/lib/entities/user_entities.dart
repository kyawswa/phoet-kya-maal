import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String phoneNumber;
  final String address;
  final String division;
  final String township;

  const UserEntity(this.id, this.username, this.phoneNumber, this.address,
      this.division, this.township);

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
        json['id'] as String,
        json['username'] as String,
        json['phone_number'] as String,
        json['address'] as String,
        json['township'] as String,
        json['division'] as String);
  }

  static UserEntity fromSnapshot(DocumentSnapshot snapshot) {
    return UserEntity(
        snapshot.documentID,
        snapshot.data['username'],
        snapshot.data['phone_number'],
        snapshot.data['address'],
        snapshot.data['township'],
        snapshot.data['division']);
  }

  Map<String, dynamic> toDocument() => {
        'username': username,
        'phone_number': phoneNumber,
        'address': address,
        'division': division,
        'township': township
      };

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'phone_number': phoneNumber,
        'address': address,
        'division': division,
        'township': township
      };

  @override
  List<Object> get props =>
      [id, username, phoneNumber, address, township, division];
}
