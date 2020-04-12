import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_app_bloc/bloc/service/login_service.dart';
import './login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginService _loginService = LoginService();

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is LoginAccount) {
      yield* _mapLoginToState(event);
    }

    if(event is LoginClose) {
      yield InitialLoginState();
    }
  }

  Stream<LoginState> _mapLoginToState(LoginEvent event) async* {
    try {
      yield LoginLoading();
      bool isAccount = await _loginService.isAccount((event as LoginAccount).accountId);
      print(isAccount);
      if(isAccount) {
        yield LoginSuccess();
      } else {
        yield LoginFail();
      }
    } catch(_) {

    }
  }
}
