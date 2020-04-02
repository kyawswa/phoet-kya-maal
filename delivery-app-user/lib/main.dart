import 'package:flutter/material.dart';
import 'package:flutter_app_bloc/pages/home_page.dart';
import 'package:flutter_app_bloc/service/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => FirestoreService(),
        child: HomePage(),
      ),
    );
  }
}
