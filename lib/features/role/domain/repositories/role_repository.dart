import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/role/data/datasources/role_remote_datasource.dart';
import 'package:manuk_pos/features/role/domain/entities/role.dart';

abstract class RoleRepository {
  Future<Either<Failures, List<Role>>> getAllRoles();
  Future<Either<Failures, Role>> getRoleById(int id);
  Future<Either<Failures, Role>> addRole(Role role);
  Future<Either<Failures, Role>> updateRoleById(int id, Role role);
  Future<Either<Failures, String>> deleteRole(int id);
}

class RoleRepositoryImpl implements RoleRepository {
  final RoleRemoteDataSource remoteDataSource;

  RoleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<Role>>> getAllRoles() async {
    try {
      final roles = await remoteDataSource.getAllRoles();
      return Right(roles);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Role>> getRoleById(int id) async {
    try {
      final role = await remoteDataSource.getRoleById(id);
      return Right(role);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Role>> addRole(Role role) async {
    try {
      final newRole = await remoteDataSource.addRole(role);
      return Right(newRole);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Role>> updateRoleById(int id, Role role) async {
    try {
      final updatedRole = await remoteDataSource.updateRoleById(id, role);
      return Right(updatedRole);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteRole(int id) async {
    try {
      final message = await remoteDataSource.deleteRole(id);
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
