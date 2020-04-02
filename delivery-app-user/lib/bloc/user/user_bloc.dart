import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_app_bloc/bloc/user/user_event.dart';
import 'package:flutter_app_bloc/bloc/user/user_state.dart';
import 'package:flutter_app_bloc/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  StreamSubscription _userSubscription;

  UserBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  UserState get initialState => UsersLoading();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async*{
    if(event is LoadUsers){
    
    }
  }

  Stream<UserState> _mapLoadUsersToState() async*{
    _userSubscription?.cancel();
   // _userSubscription = _userRepository.getAllUser().listen((event) { add() });
  }


}
