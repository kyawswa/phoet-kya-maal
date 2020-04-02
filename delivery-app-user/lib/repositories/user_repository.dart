import 'package:flutter_app_bloc/models/user.dart';

abstract class UserRepository{

  Future<void> addNewUser(User user);

  Future<void> updateUser(User user);

  Stream<List<User>> getAllUser();

}