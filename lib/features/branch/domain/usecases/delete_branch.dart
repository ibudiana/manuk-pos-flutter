import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/branch/domain/repositories/branch_repository.dart';

class DeleteBranch {
  final BranchRepository branchRepository;

  DeleteBranch(this.branchRepository);

  Future<Either<Failures, String>> call(int branchId) async {
    return await branchRepository.deleteBranch(branchId);
  }
}
