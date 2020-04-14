import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/bloc/account/account_bloc.dart';
import 'package:flutter_app_bloc/pages/home_page.dart';
import 'package:flutter_app_bloc/services/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AccountBloc accountBloc;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    accountBloc = BlocProvider.of<AccountBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Account ID',
                    icon: Icon(Icons.account_circle),
                    suffixIcon: state is AccountError
                        ? Icon(Icons.error, color: Colors.red)
                        : null,
                  ),
                  controller: textEditingController,
                  onSubmitted: (_) => _verifyAccount(),
                ),
                Divider(color: Colors.transparent),
                ButtonBar(
                  buttonMinWidth: 400,
                  children: <Widget>[
                    RaisedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (state is AccountLoading)
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          if (state is! AccountLoading) Text('Login'),
                        ],
                      ),
                      onPressed: state is! AccountLoading
                          ? () {
                              _verifyAccount();
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _verifyAccount() async {
    accountBloc.add(ShowAccountLoading());
    var adminAccount =
        await accountBloc.firestore.getAdminAccount(textEditingController.text);
    if (adminAccount == null) {
      accountBloc.add(ShowAccountError());
    } else {
      accountBloc
        ..add(GoToInitialState())
        ..adminId = adminAccount.id;
      RepositoryProvider.of<SharedPreferences>(context)
          .setString('userId', adminAccount.id);
      // TODO: navigate to dashboard_page
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => HomePage(), //TODO: replace with dashboard_page
      //   ),
      // );
    }
  }
}
