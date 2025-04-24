import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/tax/domain/repositories/tax_repository.dart';

class DeleteTax {
  final TaxRepository taxRepository;

  DeleteTax(this.taxRepository);

  Future<Either<Failures, String>> call(int id) async {
    return await taxRepository.deleteTax(id);
  }
}
