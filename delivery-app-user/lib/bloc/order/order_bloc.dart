import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_bloc/model/models.dart';
import 'package:flutter_app_bloc/service/firestore_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  StreamSubscription subscription;
  final FirestoreService firestore;
  final String userId;

  OrderBloc({
    @required this.firestore,
    this.userId,
  }) {
    subscription = firestore.getOrders().listen((snapshot) => add(
          UpdateOrder(
            snapshot.documents
                .map((document) => Order.fromMapWithID(document))
                .toList(),
          ),
        ));
  }

  @override
  OrderState get initialState => InitialState();

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is UpdateOrder) {
      yield OrderLoaded(event.orders);
    }
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
