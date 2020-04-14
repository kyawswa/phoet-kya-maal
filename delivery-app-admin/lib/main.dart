import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/bloc/account/account_bloc.dart';
import 'package:flutter_app_bloc/pages/home_page.dart';
import 'package:flutter_app_bloc/pages/login_page.dart';
import 'package:flutter_app_bloc/services/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<SharedPreferences>(
        future: futurePrefs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RepositoryProvider(
              create: (context) => snapshot.data,
              child: _buildFirstPage(context),
            );
          }
          return Container(
            color: Theme.of(context).backgroundColor,
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildFirstPage(BuildContext context) {
    return Builder(
      builder: (context) {
        var userId = RepositoryProvider.of<SharedPreferences>(context)
            .getString('userId');
        return BlocProvider(
          create: (context) => AccountBloc(FirestoreService(), adminId: userId),
          child: userId == null
              ? LoginPage()
              //TODO: return HomePage();
              : HomePage(),
        );
      },
    );
  }
}
