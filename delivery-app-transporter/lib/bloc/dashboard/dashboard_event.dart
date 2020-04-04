import 'package:equatable/equatable.dart';
import 'package:flutter_app_bloc/model/order.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadOrders extends DashboardEvent {
  final String accountId;

  LoadOrders(this.accountId);

  @override
  List<Object> get props => [accountId];
}

class UpdateStatusToDelivered extends DashboardEvent {
  final String id;
  final List<Order> orders;

  UpdateStatusToDelivered(this.id, this.orders);

  @override
  List<Object> get props => [id, orders];
}




