import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/product/data/datasources/product_remote_datasource.dart';
import 'package:manuk_pos/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failures, List<Product>>> getAllProduct();
  Future<Either<Failures, Product>> getProductById(int id);
  Future<Either<Failures, Product>> addProduct(Product product);
  Future<Either<Failures, Product>> updateProductById(int id, Product product);
  Future<Either<Failures, String>> deleteProduct(int id);
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<Product>>> getAllProduct() async {
    try {
      final products = await remoteDataSource.getAllProducts();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Product>> getProductById(int id) async {
    try {
      final product = await remoteDataSource.getProductById(id);
      return Right(product);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Product>> addProduct(Product product) async {
    try {
      final newProduct = await remoteDataSource.addProduct(product);
      return Right(newProduct);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Product>> updateProductById(
      int id, Product product) async {
    try {
      final updatedProduct =
          await remoteDataSource.updateProductById(id, product);
      return Right(updatedProduct);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteProduct(int id) async {
    try {
      final message = await remoteDataSource.deleteProduct(id);
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
