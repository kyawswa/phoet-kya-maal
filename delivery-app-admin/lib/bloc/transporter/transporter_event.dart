import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TransporterEvent extends Equatable {
@override
List<Object> get props => [];
}

class LoadTransporters extends TransporterEvent {
  final String division;

  LoadTransporters(this.division);

  @override
  List<Object> get props => [division];
}

class ConfirmTransporter extends TransporterEvent {
  final String orderId;
  final String deliveryId;

  ConfirmTransporter(this.orderId, this.deliveryId);

  @override
  List<Object> get props => [orderId, deliveryId];
}
