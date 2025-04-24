import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/supplier/domain/entities/supplier.dart';
import 'package:manuk_pos/features/supplier/domain/repositories/supplier_repository.dart';

class UpdateSupplierById {
  final SupplierRepository supplierRepository;

  UpdateSupplierById(this.supplierRepository);

  Future<Either<Failures, Supplier>> call(int id, Supplier supplier) async {
    return await supplierRepository.updateSupplierById(id, supplier);
  }
}
