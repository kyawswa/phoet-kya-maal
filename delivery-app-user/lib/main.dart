import 'package:flutter/material.dart';
import 'view/userStep1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UserStep1',
      theme: ThemeData(
    
        primarySwatch: Colors.blue,
      ),
      home: UserStep1(),
    );
  }
}
