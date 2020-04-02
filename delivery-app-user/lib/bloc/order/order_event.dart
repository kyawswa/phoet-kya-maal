part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
  List<Object> get props => [];
}

class StartFirebase extends OrderEvent {}

class UpdateOrder extends OrderEvent {
  final QuerySnapshot snapshot;

  UpdateOrder(this.snapshot);

  @override
  List<Object> get props => [snapshot];
}
