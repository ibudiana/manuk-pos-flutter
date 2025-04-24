import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/fee/domain/entities/fee.dart';
import 'package:manuk_pos/features/fee/domain/repositories/fee_repository.dart';

class GetAllFee {
  final FeeRepository feeRepository;

  GetAllFee(this.feeRepository);

  Future<Either<Failures, List<Fee>>> call() async {
    return await feeRepository.getAllFees();
  }
}
