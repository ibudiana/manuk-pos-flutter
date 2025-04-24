import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:manuk_pos/features/customer/domain/entities/customer.dart';

abstract class CustomerRepository {
  Future<Either<Failures, List<Customer>>> getAllCustomer();
  Future<Either<Failures, Customer>> getCustomerById(int id);
  Future<Either<Failures, Customer>> addCustomer(Customer customer);
  Future<Either<Failures, Customer>> updateCustomerById(
      int id, Customer customer);
  Future<Either<Failures, String>> deleteCustomer(int id);
}

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;

  CustomerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<Customer>>> getAllCustomer() async {
    try {
      final customers = await remoteDataSource.getAllCustomer();
      print("Customers: $customers");
      return Right(customers);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Customer>> getCustomerById(int id) async {
    try {
      final customer = await remoteDataSource.getCustomerById(id);
      return Right(customer);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Customer>> addCustomer(Customer customer) async {
    try {
      final newCustomer = await remoteDataSource.addCustomer(customer);
      return Right(newCustomer);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Customer>> updateCustomerById(
      int id, Customer customer) async {
    try {
      final updatedCustomer =
          await remoteDataSource.updateCustomerById(id, customer);
      return Right(updatedCustomer);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteCustomer(int id) async {
    try {
      final message = await remoteDataSource.deleteCustomer(id);
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
