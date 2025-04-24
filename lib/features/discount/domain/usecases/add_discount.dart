import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/discount/domain/entities/discount.dart';
import 'package:manuk_pos/features/discount/domain/repositories/discount_repository.dart';

class AddDiscount {
  final DiscountRepository discountRepository;

  AddDiscount(this.discountRepository);

  Future<Either<Failures, Discount>> call(Discount discount) async {
    return await discountRepository.addDiscount(discount);
  }
}
