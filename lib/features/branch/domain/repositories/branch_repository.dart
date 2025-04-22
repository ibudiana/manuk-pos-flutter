import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/branch/data/datasources/branch_remote_datasource.dart';
import 'package:manuk_pos/features/branch/domain/entities/branch.dart';

abstract class BranchRepository {
  Future<Either<Failures, List<Branch>>> getAllBranches();
  Future<Either<Failures, Branch>> getBranchById(int id);
  Future<Either<Failures, Branch>> addBranch(Branch branch);
  Future<Either<Failures, Branch>> updateBranchById(int id, Branch branch);
  Future<Either<Failures, String>> deleteBranch(int id);
}

class BranchRepositoryImpl implements BranchRepository {
  final BranchRemoteDataSource remoteDataSource;

  BranchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<Branch>>> getAllBranches() async {
    try {
      final branches = await remoteDataSource.getAllBranches();
      return Right(branches);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Branch>> getBranchById(int id) async {
    try {
      final branch = await remoteDataSource.getBranchById(id);
      return Right(branch);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Branch>> addBranch(Branch branch) async {
    try {
      final newBranch = await remoteDataSource.addBranch(branch);
      return Right(newBranch);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Branch>> updateBranchById(
      int id, Branch branch) async {
    try {
      final updatedBranch = await remoteDataSource.updateBranchById(id, branch);
      return Right(updatedBranch);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteBranch(int id) async {
    try {
      final message = await remoteDataSource.deleteBranch(id);
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
