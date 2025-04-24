import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/fee/domain/entities/fee.dart';
import 'package:manuk_pos/features/fee/domain/repositories/fee_repository.dart';

class AddFee {
  final FeeRepository feeRepository;

  AddFee(this.feeRepository);

  Future<Either<Failures, Fee>> call(Fee fee) async {
    return await feeRepository.addFee(fee);
  }
}
