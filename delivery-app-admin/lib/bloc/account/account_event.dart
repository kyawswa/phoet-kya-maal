part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
  @override
  List<Object> get props => [];
}

class ShowAccountLoading extends AccountEvent {}

class ShowAccountError extends AccountEvent {}

class GoToInitialState extends AccountEvent {}
