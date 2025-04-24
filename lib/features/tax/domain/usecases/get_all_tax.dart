import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/tax/domain/entities/tax.dart';
import 'package:manuk_pos/features/tax/domain/repositories/tax_repository.dart';

class GetAllTax {
  final TaxRepository taxRepository;

  GetAllTax(this.taxRepository);

  Future<Either<Failures, List<Tax>>> call() async {
    return await taxRepository.getAllTaxes();
  }
}
