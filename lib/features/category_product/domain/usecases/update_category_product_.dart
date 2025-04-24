import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/category_product/domain/entities/category_product_.dart';
import 'package:manuk_pos/features/category_product/domain/repositories/category_product_repository.dart';

class UpdateCategoryById {
  final CategoryRepository categoryRepository;

  UpdateCategoryById(this.categoryRepository);

  Future<Either<Failures, Category>> call(int id, Category category) async {
    return await categoryRepository.updateCategoryById(id, category);
  }
}
