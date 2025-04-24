import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/discount/domain/entities/discount.dart';
import 'package:manuk_pos/features/discount/domain/repositories/discount_repository.dart';

class GetDiscountById {
  final DiscountRepository discountRepository;

  GetDiscountById(this.discountRepository);

  Future<Either<Failures, Discount>> call(int id) async {
    return await discountRepository.getDiscountById(id);
  }
}
