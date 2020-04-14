part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
  List<Object> get props => [];
}

class StartFirebase extends OrderEvent {}

class UpdateOrder extends OrderEvent {
  final List<Order> orders;

  UpdateOrder(this.orders);

  @override
  List<Object> get props => [orders];
}
