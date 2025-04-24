import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/branch/domain/entities/branch.dart';
import 'package:manuk_pos/features/branch/domain/repositories/branch_repository.dart';

class AddBranch {
  final BranchRepository branchRepository;

  AddBranch(this.branchRepository);

  Future<Either<Failures, Branch>> call(Branch branch) async {
    return await branchRepository.addBranch(branch);
  }
}
