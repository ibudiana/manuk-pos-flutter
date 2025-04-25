import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/transaction/data/datasources/transaction_remote_datasource.dart';
import 'package:manuk_pos/features/transaction/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failures, List<Transaction>>> getAllTransactions();
  Future<Either<Failures, Transaction>> getTransactionById(int id);
  Future<Either<Failures, Transaction>> addTransaction(Transaction transaction);
  Future<Either<Failures, Transaction>> updateTransactionById(
      int id, Transaction transaction);
  Future<Either<Failures, String>> deleteTransaction(int id);
}

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<Transaction>>> getAllTransactions() async {
    try {
      final transactions = await remoteDataSource.getAllTransactions();
      return Right(transactions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Transaction>> getTransactionById(int id) async {
    try {
      final transaction = await remoteDataSource.getTransactionById(id);
      return Right(transaction);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Transaction>> addTransaction(
      Transaction transaction) async {
    try {
      final newTransaction = await remoteDataSource.addTransaction(transaction);
      return Right(newTransaction);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Transaction>> updateTransactionById(
      int id, Transaction transaction) async {
    try {
      final updatedTransaction =
          await remoteDataSource.updateTransactionById(id, transaction);
      return Right(updatedTransaction);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteTransaction(int id) async {
    try {
      final message = await remoteDataSource.deleteTransaction(id);
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
