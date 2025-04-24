import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/fee/domain/repositories/fee_repository.dart';

class DeleteFee {
  final FeeRepository feeRepository;

  DeleteFee(this.feeRepository);

  Future<Either<Failures, String>> call(int id) async {
    return await feeRepository.deleteFee(id);
  }
}
