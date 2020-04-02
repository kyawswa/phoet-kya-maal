import 'package:flutter/widgets.dart';
import 'package:flutter_app_bloc/entities/user_entities.dart';

@immutable
class User {
  final String id;
  final String username;
  final String phoneNumber;
  final String address;
  final String division;
  final String township;

  User(
      {String username = '',
      String phoneNumber = '',
      String address = '',
      String division = '',
      String township = '',
      String id})
      : this.username = username ?? '',
        this.phoneNumber = phoneNumber ?? '',
        this.address = address ?? '',
        this.township = township ?? '',
        this.division = division ?? '',
        this.id = id;

  UserEntity toEntity() {
    return UserEntity(id, username, phoneNumber, address, division, township);
  }

  static User fromEntity(UserEntity entity) {
    return User(
        id: entity.id,
        username: entity.username,
        phoneNumber: entity.phoneNumber,
        address: entity.address,
        division: entity.division,
        township: entity.township);
  }
}
