import 'package:equatable/equatable.dart';
import 'package:flutter_app_bloc/model/transporter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TransporterState extends Equatable {
  const TransporterState();

  @override
  List<Object> get props => [];
}

class InitialTransporterState extends TransporterState {}

class TransporterLoading extends TransporterState {}

class TransporterLoaded extends TransporterState {
  final List<Transporter> transporters;

  TransporterLoaded(this.transporters);

  @override
  List<Object> get props => [transporters];
}
