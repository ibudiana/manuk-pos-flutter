import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/supplier/domain/entities/supplier.dart';
import 'package:manuk_pos/features/supplier/domain/repositories/supplier_repository.dart';

class AddSupplier {
  final SupplierRepository supplierRepository;

  AddSupplier(this.supplierRepository);

  Future<Either<Failures, Supplier>> call(Supplier supplier) async {
    return await supplierRepository.addSupplier(supplier);
  }
}
