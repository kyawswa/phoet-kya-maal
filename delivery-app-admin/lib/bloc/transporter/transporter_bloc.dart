import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_app_bloc/model/transporter.dart';
import 'package:flutter_app_bloc/service/transporter_service.dart';
import './transporter.dart';

class TransporterBloc extends Bloc<TransporterEvent, TransporterState> {

  TransporterService transporterService= TransporterService();
  @override
  TransporterState get initialState => InitialTransporterState();



  @override
  Stream<TransporterState> mapEventToState(
    TransporterEvent event,
  ) async* {
    // TODO: Add Logic
    if(event is LoadTransporters) {
      yield* _mapLoadTransportersToState(event);
    }

    if(event is ConfirmTransporter) {
      transporterService.assignOrder(event.orderId, event.deliveryId);
      // navigate to success
    }
  }

  Stream<TransporterState> _mapLoadTransportersToState(TransporterEvent event) async* {
    try {
      yield TransporterLoading();
      List<Transporter> transporter = await transporterService.getTransporters((event as LoadTransporters).division);
      yield TransporterLoaded(transporter);
    } catch(_) {

    }
  }
}
