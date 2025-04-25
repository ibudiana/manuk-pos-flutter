import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/transaction/domain/entities/transaction.dart';
import 'package:manuk_pos/features/transaction/domain/repositories/transaction_repository.dart';

class GetAllTransaction {
  final TransactionRepository transactionRepository;

  GetAllTransaction(this.transactionRepository);

  Future<Either<Failures, List<Transaction>>> call() async {
    return await transactionRepository.getAllTransactions();
  }
}
