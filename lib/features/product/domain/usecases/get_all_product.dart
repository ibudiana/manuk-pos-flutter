import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/product/domain/entities/product.dart';
import 'package:manuk_pos/features/product/domain/repositories/product_repository.dart';

class GetAllProduct {
  final ProductRepository productRepository;

  GetAllProduct(this.productRepository);

  Future<Either<Failures, List<Product>>> call() async {
    return await productRepository.getAllProduct();
  }
}
