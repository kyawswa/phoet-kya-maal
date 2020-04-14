import 'package:equatable/equatable.dart';
import 'package:flutter_app_bloc/model/models.dart';
import 'package:meta/meta.dart';

import 'filter_state.dart';

@immutable
abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class UpdateFilter extends FilterEvent {
  final VisibilityFilter filter;

  const UpdateFilter(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}

class UpdateOrders extends FilterEvent {
  final List<Order> orders;

  const UpdateOrders(this.orders);

  @override
  List<Object> get props => [orders];

  @override
  String toString() => 'UpdateTodos { todos: $orders }';
}