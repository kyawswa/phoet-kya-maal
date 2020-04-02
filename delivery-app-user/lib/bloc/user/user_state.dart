import 'package:equatable/equatable.dart';
import 'package:flutter_app_bloc/models/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;

  const UsersLoaded([this.users = const []]);

  @override
  List<Object> get props => [users];
}


class UsersNotLoaded extends UserState{}