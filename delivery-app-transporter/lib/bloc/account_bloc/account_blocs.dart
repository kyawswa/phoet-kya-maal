import 'package:flutter_app_bloc/bloc/account_bloc/account.dart';
import 'package:flutter_app_bloc/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountScreenState>{
  @override
  AccountScreenState get initialState => AccountScreenLoading();

  @override
  Stream<AccountScreenState> mapEventToState(AccountEvent event) async*{
    if(event is AccountLoaded) yield* _mapViewedToState(event);
    else yield* _mapUpdatedToState(event);
  }

  Stream<AccountScreenState> _mapViewedToState(AccountEvent event) async* {
    User userAccount = (event as AccountLoaded).userAccount;
    yield AccountScreenSuccess(userAccount);
  }

  Stream<AccountScreenState> _mapUpdatedToState(AccountEvent event) async* {
    User userAccount = (event as AccountUpdated).userAccount;
    yield AccountScreenSuccess(userAccount);
  }
}