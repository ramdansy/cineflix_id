import '../../../data/repositories/transaction_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../entities/result/result.dart';
import '../../entities/transaction/transaction.dart';
import '../create_transaction/create_transaction.dart';
import '../create_transaction/create_transaction_param.dart';
import '../usecase.dart';
import 'topup_param.dart';

class TopUp implements UseCase<Result<void>, TopUpParam> {
  final TransactionRepository _transactionRepository;

  TopUp(
      {required UserRepository userRepository,
      required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(TopUpParam param) async {
    CreateTransaction createTransaction =
        CreateTransaction(transactionRepository: _transactionRepository);

    int transactionTime = DateTime.now().millisecondsSinceEpoch;

    var createTransactionResult = await createTransaction(
      CreateTransactionParam(
        transaction: Transaction(
          id: 'cnflxtp-$transactionTime-${param.userId}',
          uid: param.userId,
          title: 'Top Up',
          adminFee: 0,
          total: -param.amount,
          transactionTime: transactionTime,
        ),
      ),
    );

    return switch (createTransactionResult) {
      Success(value: _) => const Result.success(null),
      Failed(message: _) => const Result.failed('Failed to top up')
    };
  }
}
