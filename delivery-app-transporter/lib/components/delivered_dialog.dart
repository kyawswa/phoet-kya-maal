import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_bloc/main.dart';

AlertDialog deliveredDialog(BuildContext context){
  return AlertDialog(title: Text("Order Delivered"), content: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text("Thank you and good job!"),
      Text("Your order has been successfully delivered", textAlign: TextAlign.center,),
      IconButton(icon: Icon(Icons.reply), color: Colors.blue,iconSize: 100, onPressed: ()=>Navigator.popUntil(context, (route) => route.settings.name == MyApp.INITIAL_ROUTE ),),
      Text("Go Back")
    ],
  ),);
}