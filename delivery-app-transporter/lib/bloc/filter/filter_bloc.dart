import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_app_bloc/bloc/dashboard/dashboard.dart';
import 'package:flutter_app_bloc/bloc/dashboard/dashboard_bloc.dart';
import 'package:flutter_app_bloc/model/models.dart';
import './fliter.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final DashboardBloc dashboardBloc;
  StreamSubscription ordersSubscription;

  FilterBloc(this.dashboardBloc) {
    ordersSubscription = dashboardBloc.listen((state) {
      if (state is DashboardLoaded) {
        add(UpdateOrders((dashboardBloc.state as DashboardLoaded).orders));
      }
    });
  }

  @override
  FilterState get initialState {
    return dashboardBloc.state is DashboardLoaded
        ? FilteredLoaded(
            (dashboardBloc.state as DashboardLoaded).orders,
            VisibilityFilter.PENDING,
          )
        : FilteredLoading();
  }

  @override
  Stream<FilterState> mapEventToState(
    FilterEvent event,
  ) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateOrders) {
      yield* _mapOrdersUpdatedToState(event);
    }
  }

  Stream<FilterState> _mapUpdateFilterToState(
      UpdateFilter event,
      ) async* {
    if (dashboardBloc.state is DashboardLoaded) {
      yield FilteredLoaded(
        _mapOrdersToFilteredOrders(
          (dashboardBloc.state as DashboardLoaded).orders,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilterState> _mapOrdersUpdatedToState(
      UpdateOrders event,
      ) async* {
    final visibilityFilter = state is FilteredLoaded
        ? (state as FilteredLoaded).activeFilter
        : VisibilityFilter.PENDING;
    yield FilteredLoaded(
      _mapOrdersToFilteredOrders(
        (dashboardBloc.state as DashboardLoaded).orders,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Order> _mapOrdersToFilteredOrders(
      List<Order> orders, VisibilityFilter filter) {
    return orders;

    // TODO: to reconsider with state change
//    return orders.where((order) {
//      if (filter == VisibilityFilter.PENDING) {
//        return order.status == OrderState.PENDING.toShortString();
//      }
//      return order.status == OrderState.ACCEPT.toShortString() ||
//          order.status == OrderState.ASSIGN.toShortString();
//    }).toList();
  }

  @override
  Future<void> close() {
    ordersSubscription.cancel();
    return super.close();
  }
}
