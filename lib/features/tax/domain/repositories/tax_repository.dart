import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/tax/data/datasources/tax_remote_datasource.dart';
import 'package:manuk_pos/features/tax/domain/entities/tax.dart';

abstract class TaxRepository {
  Future<Either<Failures, List<Tax>>> getAllTaxes();
  Future<Either<Failures, Tax>> getTaxById(int id);
  Future<Either<Failures, Tax>> addTax(Tax tax);
  Future<Either<Failures, Tax>> updateTaxById(int id, Tax tax);
  Future<Either<Failures, String>> deleteTax(int id);
}

class TaxRepositoryImpl implements TaxRepository {
  final TaxRemoteDataSource remoteDataSource;

  TaxRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<Tax>>> getAllTaxes() async {
    try {
      final taxes = await remoteDataSource.getAllTaxes();
      return Right(taxes);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Tax>> getTaxById(int id) async {
    try {
      final tax = await remoteDataSource.getTaxById(id);
      return Right(tax);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Tax>> addTax(Tax tax) async {
    try {
      final newTax = await remoteDataSource.addTax(tax);
      return Right(newTax);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Tax>> updateTaxById(int id, Tax tax) async {
    try {
      final updatedTax = await remoteDataSource.updateTaxById(id, tax);
      return Right(updatedTax);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteTax(int id) async {
    try {
      final message = await remoteDataSource.deleteTax(id);
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
