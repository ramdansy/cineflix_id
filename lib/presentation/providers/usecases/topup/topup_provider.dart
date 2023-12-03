import 'package:cineflix_id/domain/usecases/topup/topup.dart';
import 'package:cineflix_id/presentation/providers/repositories/transaction_repository/transaction_repository_provider.dart';
import 'package:cineflix_id/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'topup_provider.g.dart';

@riverpod
TopUp topUp(TopUpRef ref) => TopUp(
    userRepository: ref.watch(userRepositoryProvider),
    transactionRepository: ref.watch(transactionRepositoryProvider));
