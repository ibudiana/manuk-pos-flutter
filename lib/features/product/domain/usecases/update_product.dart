import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/product/domain/entities/product.dart';
import 'package:manuk_pos/features/product/domain/repositories/product_repository.dart';

class UpdateProductById {
  final ProductRepository productRepository;

  UpdateProductById(this.productRepository);

  Future<Either<Failures, Product>> call(int id, Product product) async {
    return await productRepository.updateProductById(id, product);
  }
}
