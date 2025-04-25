import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/transaction/domain/entities/transaction.dart';
import 'package:manuk_pos/features/transaction/domain/repositories/transaction_repository.dart';

class AddTransaction {
  final TransactionRepository transactionRepository;

  AddTransaction(this.transactionRepository);

  Future<Either<Failures, Transaction>> call(Transaction transaction) async {
    return await transactionRepository.addTransaction(transaction);
  }
}
