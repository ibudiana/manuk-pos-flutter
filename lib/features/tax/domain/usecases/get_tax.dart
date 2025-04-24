import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/tax/domain/entities/tax.dart';
import 'package:manuk_pos/features/tax/domain/repositories/tax_repository.dart';

class GetTaxById {
  final TaxRepository taxRepository;

  GetTaxById(this.taxRepository);

  Future<Either<Failures, Tax>> call(int id) async {
    return await taxRepository.getTaxById(id);
  }
}
