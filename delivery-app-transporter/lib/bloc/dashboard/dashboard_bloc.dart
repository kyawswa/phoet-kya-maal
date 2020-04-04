import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_app_bloc/model/models.dart';
import 'package:flutter_app_bloc/service/order_service.dart';
import './dashboard.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
//  OrderService orderService = OrderService();
  final OrderService orderService;

  DashboardBloc(this.orderService);

  @override
  DashboardState get initialState => InitialDashboardState();

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if(event is LoadOrders) {
      yield* _mapLoadOrdersToState(event);
    }
    if(event is UpdateStatusToDelivered) {
      yield* _mapDeliverOrderToState(event);
    }
  }

  Stream<DashboardState> _mapLoadOrdersToState(DashboardEvent event) async* {
    try {
      yield DashboardLoading();
      List<Order> orders = await orderService.getOrders((event as LoadOrders).accountId);
      yield DashboardLoaded(orders);
    } catch(_) {

    }
  }

  Stream<DashboardState> _mapDeliverOrderToState(DashboardEvent event) async* {
    yield StatusUpdating();
    String id = (event as UpdateStatusToDelivered).id;
    List<Order> orders = (event as UpdateStatusToDelivered).orders;

    List<Order> toUpdate = orders.where((order) => order.id != id).toList();

//    orderService.processOrder(id, OrderState.PENDING); // for testing purpose
    orderService.processOrder(id, OrderState.DELIVERED);

    yield DashboardLoaded(toUpdate);


  }
}
