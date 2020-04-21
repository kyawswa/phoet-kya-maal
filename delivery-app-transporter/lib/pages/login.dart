import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/bloc/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ပို့ကြမယ်'),
        centerTitle: true,
      ),
      body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginFail) {
          return AlertDialog(
            title: Text('Wrong'),
            actions: <Widget>[
              FlatButton(
                child: Text('close'),
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(LoginClose());
                },
              )
            ],
          );
        }

        if (state is LoginSuccess) {
          print("navigate to dashboard page");
        }

//        if(state is LoginLoading) {
//          return Center(child: CircularProgressIndicator());
//        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 1.8,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Account ID',
                    border: OutlineInputBorder(),
                  ),
                  controller: controller,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 1.8,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    String account = controller.text;
                    if (account == '') {
                      return;
                    }

                    print(account);

                    BlocProvider.of<LoginBloc>(context)
                        .add(LoginAccount(account));
                  },
                  child:
                      (state is LoginLoading)
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                          : Text('Login', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
