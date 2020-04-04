import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/pages/dashboard.dart';
import 'package:flutter_app_bloc/service/order_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dashboard/dashboard.dart';

void main() {
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<DashboardBloc>(
            create: (BuildContext context) => DashboardBloc(OrderService())
                  ..add(LoadOrders('')), // TODO to get accountId
          ),
        ],
        child: MyApp(),
      )
  );
}

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


