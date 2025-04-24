import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/supplier/data/datasources/supplier_remote_datasource.dart';
import 'package:manuk_pos/features/supplier/domain/entities/supplier.dart';

abstract class SupplierRepository {
  Future<Either<Failures, List<Supplier>>> getAllSupplier();
  Future<Either<Failures, Supplier>> getSupplierById(int id);
  Future<Either<Failures, Supplier>> addSupplier(Supplier supplier);
  Future<Either<Failures, Supplier>> updateSupplierById(
      int id, Supplier supplier);
  Future<Either<Failures, String>> deleteSupplier(int id);
}

class SupplierRepositoryImpl implements SupplierRepository {
  final SupplierRemoteDataSource remoteDataSource;

  SupplierRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<Supplier>>> getAllSupplier() async {
    try {
      final suppliers = await remoteDataSource.getAllSupplier();
      return Right(suppliers);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Supplier>> getSupplierById(int id) async {
    try {
      final supplier = await remoteDataSource.getSupplierById(id);
      return Right(supplier);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Supplier>> addSupplier(Supplier supplier) async {
    try {
      final newSupplier = await remoteDataSource.addSupplier(supplier);
      return Right(newSupplier);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Supplier>> updateSupplierById(
      int id, Supplier supplier) async {
    try {
      final updatedSupplier =
          await remoteDataSource.updateSupplierById(id, supplier);
      return Right(updatedSupplier);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteSupplier(int id) async {
    try {
      final message = await remoteDataSource.deleteSupplier(id);
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
