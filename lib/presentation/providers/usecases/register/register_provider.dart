import 'package:cineflix_id/domain/usecases/register/register.dart';
import 'package:cineflix_id/presentation/providers/repositories/authentication/authentication_provider.dart';
import 'package:cineflix_id/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_provider.g.dart';

@riverpod
Register register(RegisterRef ref) => Register(
    authentication: ref.watch(authenticationProvider),
    userRepository: ref.watch(userRepositoryProvider));
