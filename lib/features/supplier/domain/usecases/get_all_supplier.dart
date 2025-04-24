import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/supplier/domain/entities/supplier.dart';
import 'package:manuk_pos/features/supplier/domain/repositories/supplier_repository.dart';

class GetAllSupplier {
  final SupplierRepository supplierRepository;

  GetAllSupplier(this.supplierRepository);

  Future<Either<Failures, List<Supplier>>> call() async {
    return await supplierRepository.getAllSupplier();
  }
}
