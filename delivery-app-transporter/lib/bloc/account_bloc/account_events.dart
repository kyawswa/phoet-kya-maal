import 'package:equatable/equatable.dart';
import 'package:flutter_app_bloc/models/models.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountLoaded extends AccountEvent{
  final User userAccount;

  AccountLoaded(this.userAccount);

  @override
  List<Object> get props => [userAccount];
}

class AccountUpdated extends AccountEvent{
  final User userAccount;

  AccountUpdated(this.userAccount);

  @override
  List<Object> get props => [userAccount];
}