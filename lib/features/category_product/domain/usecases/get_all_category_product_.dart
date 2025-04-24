import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/category_product/domain/entities/category_product_.dart';
import 'package:manuk_pos/features/category_product/domain/repositories/category_product_repository.dart';

class GetAllCategory {
  final CategoryRepository categoryRepository;

  GetAllCategory(this.categoryRepository);

  Future<Either<Failures, List<Category>>> call() async {
    return await categoryRepository.getAllCategories();
  }
}
