import 'package:flutter/material.dart';

AlertDialog deliveredDialog(BuildContext context){
  return AlertDialog(title: Text("Order Delivered"), content: Center(child: Container(
    height: 400,
    child: Column(
    children: <Widget>[
      Text("Thank you and good job!"),
      Text("Your order has been successfully delivered"),
      IconButton(icon: Icon(Icons.reply), iconSize: 20, onPressed: ()=>Navigator.popUntil(context, (route) => false ),)
    ],
  ),),));
}