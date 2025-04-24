import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/discount/domain/repositories/discount_repository.dart';

class DeleteDiscount {
  final DiscountRepository discountRepository;

  DeleteDiscount(this.discountRepository);

  Future<Either<Failures, String>> call(int id) async {
    return await discountRepository.deleteDiscount(id);
  }
}
