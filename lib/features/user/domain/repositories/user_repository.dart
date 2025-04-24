import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/user/data/datasources/user_remote_datasource.dart';
import 'package:manuk_pos/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failures, List<User>>> getAllUsers();
  Future<Either<Failures, User>> getUserById(int id);
  Future<Either<Failures, User>> updateUserById(int id, User user);
  Future<Either<Failures, User>> addUser(User user);
  Future<Either<Failures, String>> deleteUser(int id);
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<User>>> getAllUsers() async {
    try {
      final users = await remoteDataSource.getAllUsers();
      return Right(users);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, User>> getUserById(int id) async {
    try {
      final user = await remoteDataSource.getUserById(id);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, User>> addUser(User user) async {
    try {
      final newUser = await remoteDataSource.addUser(user);
      return Right(newUser);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteUser(int id) async {
    try {
      final message = await remoteDataSource.deleteUser(id);
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, User>> updateUserById(int id, User user) async {
    try {
      final updatedUser = await remoteDataSource.updateUserById(id, user);
      return Right(updatedUser);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
