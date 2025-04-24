import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/fee/data/datasources/fee_remote_datasource.dart';
import 'package:manuk_pos/features/fee/domain/entities/fee.dart';

abstract class FeeRepository {
  Future<Either<Failures, List<Fee>>> getAllFees();
  Future<Either<Failures, Fee>> getFeeById(int id);
  Future<Either<Failures, Fee>> addFee(Fee fee);
  Future<Either<Failures, Fee>> updateFeeById(int id, Fee fee);
  Future<Either<Failures, String>> deleteFee(int id);
}

class FeeRepositoryImpl implements FeeRepository {
  final FeeRemoteDataSource remoteDataSource;

  FeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<Fee>>> getAllFees() async {
    try {
      final fees = await remoteDataSource.getAllFees();
      return Right(fees);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Fee>> getFeeById(int id) async {
    try {
      final fee = await remoteDataSource.getFeeById(id);
      return Right(fee);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Fee>> addFee(Fee fee) async {
    try {
      final newFee = await remoteDataSource.addFee(fee);
      return Right(newFee);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Fee>> updateFeeById(int id, Fee fee) async {
    try {
      final updatedFee = await remoteDataSource.updateFeeById(id, fee);
      return Right(updatedFee);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteFee(int id) async {
    try {
      final message = await remoteDataSource.deleteFee(id);
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
