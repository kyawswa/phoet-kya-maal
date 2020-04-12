import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginClose extends LoginEvent {}

class LoginAccount extends LoginEvent {
  final String accountId;

  LoginAccount(this.accountId);
}
