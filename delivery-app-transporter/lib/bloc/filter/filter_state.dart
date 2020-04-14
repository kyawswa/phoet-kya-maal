import 'package:equatable/equatable.dart';
import 'package:flutter_app_bloc/model/models.dart';
import 'package:meta/meta.dart';


enum VisibilityFilter { ASSIGN, PENDING}

@immutable
abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilteredLoading extends FilterState {}

class FilteredLoaded extends FilterState {
  final List<Order> filteredOrders;
  final VisibilityFilter activeFilter;

  const FilteredLoaded(
      this.filteredOrders,
      this.activeFilter,
  );

  @override
  List<Object> get props => [filteredOrders, activeFilter];

  @override
  String toString() {
    return 'FilteredTodosLoaded { filteredTodos: $filteredOrders, activeFilter: $activeFilter }';
  }
}

