import 'package:equatable/equatable.dart';
import 'package:flutter_app_bloc/models/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UserEvent {}

class AddUser extends UserEvent {
  final User user;

  const AddUser(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateUser extends UserEvent {
  final User updateUser;

  const UpdateUser(this.updateUser);

  @override
  List<Object> get props => [updateUser];
}
