import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/tax/domain/entities/tax.dart';
import 'package:manuk_pos/features/tax/domain/repositories/tax_repository.dart';

class UpdateTaxById {
  final TaxRepository taxRepository;

  UpdateTaxById(this.taxRepository);

  Future<Either<Failures, Tax>> call(int id, Tax tax) async {
    return await taxRepository.updateTaxById(id, tax);
  }
}
