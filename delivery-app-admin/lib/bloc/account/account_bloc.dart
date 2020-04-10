import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_bloc/models/admin.dart';
import 'package:flutter_app_bloc/services/firestore_service.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  String adminId;
  final FirestoreService firestore;
  @override
  AccountState get initialState => AccountInitial();

  AccountBloc(this.firestore, {this.adminId});

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is ShowAccountLoading) {
      yield AccountLoading();
    } else if (event is ShowAccountError) {
      yield AccountError();
    } else {
      yield AccountInitial();
    }
  }
}
