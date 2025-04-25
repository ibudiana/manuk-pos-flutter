import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/transaction/domain/entities/transaction.dart';
import 'package:manuk_pos/features/transaction/domain/repositories/transaction_repository.dart';

class GetTransactionById {
  final TransactionRepository transactionRepository;

  GetTransactionById(this.transactionRepository);

  Future<Either<Failures, Transaction>> call(int id) async {
    return await transactionRepository.getTransactionById(id);
  }
}
