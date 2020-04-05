
import 'package:flutter_app_bloc/bloc/order_bloc/order.dart';
import 'package:flutter_app_bloc/models/models.dart';
import 'package:flutter_app_bloc/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderViewState>{
  final OrderService orderService;

  OrderBloc(this.orderService);

  @override
  // TODO: implement initialState
  OrderViewState get initialState => OrderViewLoading();

  @override
  Stream<OrderViewState> mapEventToState(OrderEvent event) async*{
    // TODO: implement mapEventToState
    if(event is OrderAccepted) yield* _mapAcceptedToState(event);
    else if(event is OrderRejected) yield* _mapRejectedToState(event);
    else if(event is OrderCancelled) yield* _mapCancelledToState(event);
    else if(event is OrderAdded) yield* _mapAddedToState(event);
    else yield* _mapDeliveredToState(event);
  }

  Stream<OrderViewState> _mapAddedToState(OrderAdded event) async*{
    yield OrderViewSuccess(event.order);
  }

  Stream<OrderViewState> _mapAcceptedToState(OrderAccepted event) async*{
    final Order order = event.order;
    try{
      yield OrderViewLoading();
      order.status = OrderState.ACCEPT.toString();
//      await orderService.processOrder(order.id, OrderState.ACCEPT);
      yield OrderViewSuccess(order);
    }catch(_){
      yield OrderViewFailure("Error. Failed To Accept", order);
    }
  }

  Stream<OrderViewState> _mapCancelledToState(OrderCancelled event) async*{
    final Order order = event.order;
    try{
      yield OrderViewLoading();
      order.status = OrderState.CANCELLED.toString();
//      await orderService.processOrder(order.id, OrderState.CANCELLED);
      yield OrderViewSuccess(order);
    }catch(_){
      yield OrderViewFailure("Error. Failed To Cancel", order);
    }
  }

  Stream<OrderViewState> _mapRejectedToState(OrderRejected event) async*{
    final Order order = event.order;
    try{
      yield OrderViewLoading();
      order.status = OrderState.REJECT.toString();
//      await orderService.processOrder(order.id, OrderState.REJECT);
      yield OrderViewSuccess(order);
    }catch(_){
      yield OrderViewFailure("Error. Failed To Reject", order);
    }
  }

  Stream<OrderViewState> _mapDeliveredToState(OrderDelivered event) async*{
    final Order order = event.order;
    try{
      yield OrderViewLoading();
      order.status = OrderState.DELIVERED.toString();
//      await orderService.processOrder(order.id, OrderState.DELIVERED);
      yield OrderViewSuccess(order);
    }catch(_){
      yield OrderViewFailure("Error. Failed To Cancel", order);
    }
  }
}