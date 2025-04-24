import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/tax/domain/entities/tax.dart';
import 'package:manuk_pos/features/tax/domain/repositories/tax_repository.dart';

class AddTax {
  final TaxRepository taxRepository;

  AddTax(this.taxRepository);

  Future<Either<Failures, Tax>> call(Tax tax) async {
    return await taxRepository.addTax(tax);
  }
}
