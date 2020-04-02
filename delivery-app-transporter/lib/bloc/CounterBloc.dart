import 'dart:async';

import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  // TODO: implement initialState
  int get initialState => null;

  @override
  Stream<int> mapEventToState(CounterEvent event) {
    // TODO: implement mapEventToState
    return null;
  }

}

class SimpleBlocDelegate extends BlocDelegate {

}