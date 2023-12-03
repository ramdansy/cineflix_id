import 'dart:io';

import 'package:cineflix_id/domain/entities/user/user.dart';
import 'package:cineflix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/result/result.dart';
import '../../../domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import '../../../domain/usecases/login/login.dart';
import '../../../domain/usecases/login/login_params.dart';
import '../../../domain/usecases/register/register.dart';
import '../../../domain/usecases/register/register_param.dart';
import '../../../domain/usecases/topup/topup.dart';
import '../../../domain/usecases/topup/topup_param.dart';
import '../../../domain/usecases/upload_profile_picture/upload_profile_picture.dart';
import '../../../domain/usecases/upload_profile_picture/upload_profile_picture_param.dart';
import '../movie/now_playing/now_playing_provider.dart';
import '../movie/upcoming/upcoming_provider.dart';
import '../usecases/get_logged_in_user/get_logged_in_user_provider.dart';
import '../usecases/login/login_provider.dart';
import '../usecases/logout/logout_provider.dart';
import '../usecases/register/register_provider.dart';
import '../usecases/topup/topup_provider.dart';
import '../usecases/upload_profile_picture/upload_profile_picture_provider.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);
    var userResult = await getLoggedInUser(null);

    switch (userResult) {
      case Success(value: final user):
        _getMovies();
        return user;
      case Failed(message: _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    Login login = ref.read(loginProvider);

    var result = await login(LoginParams(email: email, password: password));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name,
      String? imageUrl}) async {
    state = const AsyncLoading();

    Register register = ref.read(registerProvider);

    var result = await register(RegisterParam(
        name: name, email: email, password: password, photoUrl: imageUrl));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> refreshUserData() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    var result = await getLoggedInUser(null);

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  Future<void> logout() async {
    var logout = ref.read(logoutProvider);
    var result = await logout(null);

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> topUp(int amount) async {
    TopUp topUp = ref.read(topUpProvider);

    String? userId = state.valueOrNull?.uid;

    if (userId != null) {
      var result = await topUp(TopUpParam(amount: amount, userId: userId));

      if (result.isSuccess) {
        refreshUserData();
        ref.read(transactionDataProvider.notifier).refreshTransactionData();
      }
    }
  }

  Future<void> uploadProfilePicture(
      {required User user, required File imageFile}) async {
    UploadProfilePicture uploadProfilePicture =
        ref.read(uploadProfilePictureProvider);

    var result = await uploadProfilePicture(
        UploadProfilePictureParam(imageFile: imageFile, user: user));

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  void _getMovies() {
    ref.read(nowPlayingProvider.notifier);
    ref.read(upcomingProvider.notifier);
  }
}
