import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/discount/domain/entities/discount.dart';
import 'package:manuk_pos/features/discount/domain/repositories/discount_repository.dart';

class UpdateDiscountById {
  final DiscountRepository discountRepository;

  UpdateDiscountById(this.discountRepository);

  Future<Either<Failures, Discount>> call(int id, Discount discount) async {
    return await discountRepository.updateDiscountById(id, discount);
  }
}
