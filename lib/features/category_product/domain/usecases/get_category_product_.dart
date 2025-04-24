import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/category_product/domain/entities/category_product_.dart';
import 'package:manuk_pos/features/category_product/domain/repositories/category_product_repository.dart';

class GetCategoryById {
  final CategoryRepository categoryRepository;

  GetCategoryById(this.categoryRepository);

  Future<Either<Failures, Category>> call(int id) async {
    return await categoryRepository.getCategoryById(id);
  }
}
