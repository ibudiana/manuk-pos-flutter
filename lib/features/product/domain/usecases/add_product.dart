import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/product/domain/entities/product.dart';
import 'package:manuk_pos/features/product/domain/repositories/product_repository.dart';

class AddProduct {
  final ProductRepository productRepository;

  AddProduct(this.productRepository);

  Future<Either<Failures, Product>> call(Product product) async {
    return await productRepository.addProduct(product);
  }
}
