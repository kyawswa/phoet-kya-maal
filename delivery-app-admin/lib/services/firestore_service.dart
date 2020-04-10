import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_bloc/models/admin.dart';

class FirestoreService {
  final Firestore firestore = Firestore.instance;

  Future<List<DocumentSnapshot>> getAccounts(Account type) async {
    var snapshot = await firestore
        .collection('accounts')
        .where(Admin.FIELD_ROLE, isEqualTo: type.toString())
        .getDocuments();
    return snapshot.documents;
  }

  Future<Admin> getAdminAccount(String id) async {
    var snapshot = await firestore
        .collection('accounts')
        .where(Admin.FIELD_ROLE, isEqualTo: Account.ADMIN.toString())
        .where(Admin.FIELD_ID, isEqualTo: id)
        .getDocuments();
    return snapshot.documents.isEmpty
        ? null
        : Admin.fromMapWithID(snapshot.documents.first);
  }
}

class Account {
  final String _type;
  const Account._(this._type);

  @override
  String toString() => _type;

  static const ADMIN = Account._('ADMIN');
  static const DELIVERY = Account._('DELIVERY');
  static const USER = Account._('USER');
}
