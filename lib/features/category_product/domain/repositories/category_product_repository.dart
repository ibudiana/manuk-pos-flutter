import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/category_product/data/datasources/category_product_remote_datasource.dart';
import 'package:manuk_pos/features/category_product/domain/entities/category_product_.dart';

abstract class CategoryRepository {
  Future<Either<Failures, List<Category>>> getAllCategories();
  Future<Either<Failures, Category>> getCategoryById(int id);
  Future<Either<Failures, Category>> addCategory(Category category);
  Future<Either<Failures, Category>> updateCategoryById(
      int id, Category category);
  Future<Either<Failures, String>> deleteCategory(int id);
}

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<Category>>> getAllCategories() async {
    try {
      final categories = await remoteDataSource.getAllCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Category>> getCategoryById(int id) async {
    try {
      final category = await remoteDataSource.getCategoryById(id);
      return Right(category);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Category>> addCategory(Category category) async {
    try {
      final newCategory = await remoteDataSource.addCategory(category);
      return Right(newCategory);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Category>> updateCategoryById(
      int id, Category category) async {
    try {
      final updatedCategory =
          await remoteDataSource.updateCategoryById(id, category);
      return Right(updatedCategory);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> deleteCategory(int id) async {
    try {
      final message = await remoteDataSource.deleteCategory(id);
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
