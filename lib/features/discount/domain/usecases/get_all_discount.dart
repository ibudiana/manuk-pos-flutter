import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/discount/domain/entities/discount.dart';
import 'package:manuk_pos/features/discount/domain/repositories/discount_repository.dart';

class GetAllDiscounts {
  final DiscountRepository discountRepository;

  GetAllDiscounts(this.discountRepository);

  Future<Either<Failures, List<Discount>>> call() async {
    return await discountRepository.getAllDiscounts();
  }
}
