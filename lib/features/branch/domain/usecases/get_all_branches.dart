import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/branch/domain/entities/branch.dart';
import 'package:manuk_pos/features/branch/domain/repositories/branch_repository.dart';

class GetAllBranches {
  final BranchRepository repository;

  GetAllBranches(this.repository);

  Future<Either<Failures, List<Branch>>> call() async {
    return await repository.getAllBranches();
  }
}
