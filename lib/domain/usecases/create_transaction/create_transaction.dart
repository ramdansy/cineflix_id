import 'package:cineflix_id/data/repositories/transaction_repository.dart';
import 'package:cineflix_id/domain/entities/result/result.dart';
import 'package:cineflix_id/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:cineflix_id/domain/usecases/usecase.dart';

class CreateTransaction
    implements UseCase<Result<void>, CreateTransactionParam> {
  final TransactionRepository _transactionRepository;

  CreateTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(CreateTransactionParam param) async {
    int transactionTime = DateTime.now().millisecondsSinceEpoch;

    var result = await _transactionRepository.createTransaction(
      transaction: param.transaction.copyWith(
        transactionTime: transactionTime,
        id: (param.transaction.id == null)
            ? 'cnflx-$transactionTime-${param.transaction.uid}'
            : param.transaction.id,
      ),
    );

    return switch (result) {
      Success(value: _) => const Result.success(null),
      Failed(message: final message) => Result.failed(message),
    };
  }
}
