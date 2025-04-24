import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/product/domain/entities/product.dart';
import 'package:manuk_pos/features/product/domain/repositories/product_repository.dart';

class GetProductById {
  final ProductRepository productRepository;

  GetProductById(this.productRepository);

  Future<Either<Failures, Product>> call(int id) async {
    return await productRepository.getProductById(id);
  }
}
