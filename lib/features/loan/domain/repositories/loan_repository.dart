import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/loan/data/datasources/loan_remote_datasource.dart';
import 'package:manuk_pos/features/loan/domain/entities/loan.dart';

abstract class LoanRepository {
  Future<Either<Failures, List<Loan>>> getAllLoans();
  Future<Either<Failures, Loan>> getLoanById(int id);
  Future<Either<Failures, Loan>> addLoan(Loan loan);
  Future<Either<Failures, Loan>> updateLoanById(int id, Loan loan);
  Future<Either<Failures, String>> deleteLoan(int id);
}

class LoanRepositoryImpl implements LoanRepository {
  final LoanRemoteDataSource remoteDataSource;

  LoanRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<Loan>>> getAllLoans() async {
    try {
      final loans = await remoteDataSource.getAllLoans();
      return Right(loans);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Loan>> getLoanById(int id) async {
    try {
      final loan = await remoteDataSource.getLoanById(id);
      return Right(loan);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Loan>> addLoan(Loan loan) async {
    try {
      final newLoan = await remoteDataSource.addLoan(loan);
      return Right(newLoan);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Loan>> updateLoanById(int id, Loan loan) async {
    try {
      final updatedLoan = await remoteDataSource.updateLoanById(id, loan);
      return Right(updatedLoan);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteLoan(int id) async {
    try {
      final message = await remoteDataSource.deleteLoan(id);
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
