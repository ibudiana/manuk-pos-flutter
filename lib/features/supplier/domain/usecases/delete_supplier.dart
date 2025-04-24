import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/supplier/domain/repositories/supplier_repository.dart';

class DeleteSupplier {
  final SupplierRepository supplierRepository;

  DeleteSupplier(this.supplierRepository);

  Future<Either<Failures, String>> call(int id) async {
    return await supplierRepository.deleteSupplier(id);
  }
}
