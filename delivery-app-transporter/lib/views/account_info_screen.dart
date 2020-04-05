import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/bloc/account_bloc/account.dart';
import 'package:flutter_app_bloc/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfoScreen extends StatelessWidget {
  static const SCREEN_ROUTE_NAME = "ACCOUNT INFO";
  final _textStyle = TextStyle(fontSize: 20, );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountScreenState>(
      builder: (BuildContext context, AccountScreenState state) {
        User userAccount;
        bool isLoading = state is AccountScreenLoading;
        if (state is AccountScreenSuccess)
          userAccount = state.userAccount;
        else
          userAccount = User.empty();
        return Scaffold(
          appBar: AppBar(
            title: Text("Account"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {},
              )
            ],
          ),
          body: Center(
            child: isLoading ? CircularProgressIndicator() : Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Good job ${userAccount.name}!", style: _textStyle, textAlign: TextAlign.center,),
                  Text("We appreciate your works.", style: _textStyle,),
                  Text("You already delivered", style: _textStyle,),
                  SizedBox(height: 20,),
                  Text("1000", style: TextStyle(fontSize: 40),),
                  SizedBox(height: 20,),
                  Text("orders", style: _textStyle,),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
