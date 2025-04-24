import 'package:dartz/dartz.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/category_product/domain/repositories/category_product_repository.dart';

class DeleteCategory {
  final CategoryRepository categoryRepository;

  DeleteCategory(this.categoryRepository);

  Future<Either<Failures, String>> call(int id) async {
    return await categoryRepository.deleteCategory(id);
  }
}
