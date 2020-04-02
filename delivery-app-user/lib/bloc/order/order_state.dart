part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  List<Object> get props => [];
}

class InitialState extends OrderState {}

class OrderLoaded extends OrderState {
  final QuerySnapshot snapshot;

  OrderLoaded(this.snapshot);

  @override
  List<Object> get props => [snapshot];
}
