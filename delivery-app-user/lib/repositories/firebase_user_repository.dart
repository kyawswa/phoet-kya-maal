import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_bloc/entities/user_entities.dart';
import 'package:flutter_app_bloc/models/user.dart';
import 'package:flutter_app_bloc/repositories/user_repository.dart';

class FirebaseUserRepository extends UserRepository {
  final userCollection = Firestore.instance.collection('users');

  @override
  Future<void> addNewUser(User user) {
    return userCollection.add(user.toEntity().toDocument());
  }

  @override
  Stream<List<User>> getAllUser() {
    return userCollection.snapshots().map((snapshot) => snapshot.documents
        .map((docs) => User.fromEntity(UserEntity.fromSnapshot(docs)))
        .toList());
  }

  @override
  Future<void> updateUser(User user) {
    return userCollection
        .document(user.id)
        .updateData(user.toEntity().toDocument());
  }
}
