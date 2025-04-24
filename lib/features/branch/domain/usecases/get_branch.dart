import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/branch/domain/entities/branch.dart';
import 'package:manuk_pos/features/branch/domain/repositories/branch_repository.dart';

class GetBranchById {
  final BranchRepository branchRepository;

  GetBranchById(this.branchRepository);

  Future<Either<Failures, Branch>> call(int branchId) async {
    return await branchRepository.getBranchById(branchId);
  }
}
