import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/product/domain/repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository productRepository;

  DeleteProduct(this.productRepository);

  Future<Either<Failures, String>> call(int id) async {
    return await productRepository.deleteProduct(id);
  }
}
