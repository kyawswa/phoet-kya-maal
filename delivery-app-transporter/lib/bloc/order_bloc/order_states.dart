import 'package:equatable/equatable.dart';
import 'package:flutter_app_bloc/models/models.dart';

abstract class OrderViewState extends Equatable {
  const OrderViewState();

  @override
  List<Object> get props => [];
}
class OrderViewLoading extends OrderViewState{}
class OrderViewSuccess extends OrderViewState{
  final Order order;

  OrderViewSuccess(this.order);

  @override
  // TODO: implement props
  List<Object> get props => [order];
}
class OrderViewFailure extends OrderViewState{
  final String message;
  final Order order;

  OrderViewFailure(this.message, this.order);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}