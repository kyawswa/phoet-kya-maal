import 'package:equatable/equatable.dart';
import 'package:flutter_app_bloc/models/models.dart';

abstract class AccountScreenState extends Equatable {
  const AccountScreenState();

  @override
  List<Object> get props => [];
}
class AccountScreenLoading extends AccountScreenState{}
class AccountScreenSuccess extends AccountScreenState{
  final User userAccount;

  AccountScreenSuccess(this.userAccount);

  @override
  List<Object> get props => [userAccount];
}
class AccountScreenFailure extends AccountScreenState{
  final String message;
  final User userAccount;

  AccountScreenFailure(this.message, this.userAccount);

  @override
  List<Object> get props => [message, userAccount];
}