import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/bloc/CounterBloc.dart';
import 'package:flutter_app_bloc/pages/dashboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Dashboard(),
    );
  }
}


