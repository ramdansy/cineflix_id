import 'dart:io';

import '../../domain/entities/result/result.dart';
import '../../domain/entities/user/user.dart';

abstract interface class UserRepository {
  Future<Result<User>> createUser({
    required String uid,
    required String email,
    required String password,
    String? photoUrl,
    int balance = 0,
  });

  Future<Result<User>> getUser({required String uid});
  Future<Result<User>> updateUser({required String user});
  Future<Result<int>> getUserBalance({required String uid});
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance});
  Future<Result<User>> uploadProfilePicture(
      {required User user, required File imageFile});
}