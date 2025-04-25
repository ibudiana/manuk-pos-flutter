import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/transaction/domain/entities/transaction.dart';
import 'package:manuk_pos/features/transaction/domain/repositories/transaction_repository.dart';

class UpdateTransactionById {
  final TransactionRepository transactionRepository;

  UpdateTransactionById(this.transactionRepository);

  Future<Either<Failures, Transaction>> call(
      int id, Transaction transaction) async {
    return await transactionRepository.updateTransactionById(id, transaction);
  }
}
