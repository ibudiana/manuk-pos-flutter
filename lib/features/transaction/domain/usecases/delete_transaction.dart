import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/transaction/domain/repositories/transaction_repository.dart';

class DeleteTransaction {
  final TransactionRepository transactionRepository;

  DeleteTransaction(this.transactionRepository);

  Future<Either<Failures, String>> call(int id) async {
    return await transactionRepository.deleteTransaction(id);
  }
}
