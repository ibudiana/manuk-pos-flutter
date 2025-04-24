import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/discount/data/datasources/discount_remote_datasource.dart';
import 'package:manuk_pos/features/discount/domain/entities/discount.dart';

abstract class DiscountRepository {
  Future<Either<Failures, List<Discount>>> getAllDiscounts();
  Future<Either<Failures, Discount>> getDiscountById(int id);
  Future<Either<Failures, Discount>> addDiscount(Discount discount);
  Future<Either<Failures, Discount>> updateDiscountById(
      int id, Discount discount);
  Future<Either<Failures, String>> deleteDiscount(int id);
}

class DiscountRepositoryImpl implements DiscountRepository {
  final DiscountRemoteDataSource remoteDataSource;

  DiscountRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<Discount>>> getAllDiscounts() async {
    try {
      final discounts = await remoteDataSource.getAllDiscounts();
      return Right(discounts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Discount>> getDiscountById(int id) async {
    try {
      final discount = await remoteDataSource.getDiscountById(id);
      return Right(discount);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Discount>> addDiscount(Discount discount) async {
    try {
      final newDiscount = await remoteDataSource.addDiscount(discount);
      return Right(newDiscount);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Discount>> updateDiscountById(
      int id, Discount discount) async {
    try {
      final updatedDiscount =
          await remoteDataSource.updateDiscountById(id, discount);
      return Right(updatedDiscount);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteDiscount(int id) async {
    try {
      final message = await remoteDataSource.deleteDiscount(id);
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
