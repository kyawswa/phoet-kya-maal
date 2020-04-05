import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/bloc/account_bloc/account.dart';
import 'package:flutter_app_bloc/bloc/order_bloc/order.dart';
import 'package:flutter_app_bloc/views/account_info_screen.dart';
import 'package:flutter_app_bloc/views/order_details_screen.dart';
import 'package:flutter_app_bloc/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User user = User("123", "HNN", "0945116113", "AEREIAMCIAWERAR");
    Order order = Order("123", user, user, Timestamp.fromDate(DateTime.now()),
        null, OrderState.PENDING.toString(), [
          {"category": "RICE", "quantity": 2},
          {"category": "Drink", "quantity": 2},
        ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        OrderDetailsScreen.SCREEN_ROUTE_NAME: (context)=>BlocProvider<OrderBloc>(
            create: (context) => OrderBloc(OrderService())..add(OrderAdded(order)),
            child: OrderDetailsScreen(userAccount: user,),
          ),
        AccountInfoScreen.SCREEN_ROUTE_NAME: (context) {
          User user = ModalRoute.of(context).settings.arguments;
          print(user.name);
          return BlocProvider<AccountBloc>(
            create: (context) => AccountBloc()..add(AccountLoaded(user)),
            child: AccountInfoScreen(),
          );
        }
      },
      initialRoute: OrderDetailsScreen.SCREEN_ROUTE_NAME,
    );
  }
}
