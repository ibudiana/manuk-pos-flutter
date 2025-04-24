import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/supplier/domain/entities/supplier.dart';
import 'package:manuk_pos/features/supplier/domain/repositories/supplier_repository.dart';

class GetSupplierById {
  final SupplierRepository supplierRepository;

  GetSupplierById(this.supplierRepository);

  Future<Either<Failures, Supplier>> call(int id) async {
    return await supplierRepository.getSupplierById(id);
  }
}
