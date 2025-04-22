import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/branch/domain/entities/branch.dart';
import 'package:manuk_pos/features/branch/domain/repositories/branch_repository.dart';

class UpdateBranch {
  final BranchRepository branchRepository;

  UpdateBranch(this.branchRepository);

  Future<Either<Failures, Branch>> call(int branchId, Branch branch) async {
    return await branchRepository.updateBranchById(branchId, branch);
  }
}
