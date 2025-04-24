import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/fee/domain/entities/fee.dart';
import 'package:manuk_pos/features/fee/domain/repositories/fee_repository.dart';

class GetFeeById {
  final FeeRepository feeRepository;

  GetFeeById(this.feeRepository);

  Future<Either<Failures, Fee>> call(int id) async {
    return await feeRepository.getFeeById(id);
  }
}
