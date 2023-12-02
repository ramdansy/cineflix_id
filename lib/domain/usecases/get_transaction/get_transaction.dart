import 'package:cineflix_id/data/repositories/transaction_repository.dart';
import 'package:cineflix_id/domain/entities/result/result.dart';
import 'package:cineflix_id/domain/entities/transaction/transaction.dart';
import 'package:cineflix_id/domain/usecases/get_transaction/get_transaction_param.dart';
import 'package:cineflix_id/domain/usecases/usecase.dart';

class GetTransaction
    implements UseCase<Result<List<Transaction>>, GetTransactionParam> {
  final TransactionRepository _transactionRepository;

  GetTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<List<Transaction>>> call(GetTransactionParam param) async {
    var transactionList =
        await _transactionRepository.getUserTransaction(uid: param.uId);

    return switch (transactionList) {
      Success(value: final transactionList) => Result.success(transactionList),
      Failed(:final message) => Result.failed(message),
    };
  }
}
