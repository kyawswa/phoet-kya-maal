import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// copy from branch::issue 2 - 4
class LoginService{
  final Firestore _firestore = Firestore.instance;

  Future isAccount(String accountId) async {
    Query query = _firestore.collection('accounts')
        .where('id', isEqualTo: accountId);


    var querySnapshot = await query.getDocuments();
    var totalEquals = querySnapshot.documents.length;
    return totalEquals >= 1;
  }
}