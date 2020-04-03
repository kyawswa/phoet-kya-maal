import 'package:equatable/equatable.dart';
import 'package:flutter_app_bloc/models.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderAccepted extends OrderEvent{
  final Order order;

  OrderAccepted(this.order);

  @override
  // TODO: implement props
  List<Object> get props => [order];
}


class OrderRejected extends OrderEvent{
  final Order order;

  OrderRejected(this.order);

  @override
  // TODO: implement props
  List<Object> get props => [order];
}

class OrderAdded extends OrderEvent{
  final Order order;

  OrderAdded(this.order);

  @override
  // TODO: implement props
  List<Object> get props => [order];
}

class OrderCancelled extends OrderEvent{
  final Order order;

  OrderCancelled(this.order);

  @override
  // TODO: implement props
  List<Object> get props => [order];
}

class OrderDelivered extends OrderEvent{
  final Order order;

  OrderDelivered(this.order);

  @override
  // TODO: implement props
  List<Object> get props => [order];
}
