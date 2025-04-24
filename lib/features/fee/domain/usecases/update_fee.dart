import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/fee/domain/entities/fee.dart';
import 'package:manuk_pos/features/fee/domain/repositories/fee_repository.dart';

class UpdateFeeById {
  final FeeRepository feeRepository;

  UpdateFeeById(this.feeRepository);

  Future<Either<Failures, Fee>> call(int id, Fee fee) async {
    return await feeRepository.updateFeeById(id, fee);
  }
}
