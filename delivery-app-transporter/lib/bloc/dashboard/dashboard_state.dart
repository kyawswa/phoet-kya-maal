import 'package:flutter_app_bloc/model/models.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class InitialDashboardState extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<Order> orders;

  DashboardLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class StatusUpdating extends DashboardState {}

class StatusUpdated extends DashboardState {}
