import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/category_product/domain/entities/category_product_.dart';
import 'package:manuk_pos/features/category_product/domain/usecases/add_category_product_.dart';
import 'package:manuk_pos/features/category_product/domain/usecases/delete_category_product_.dart';
import 'package:manuk_pos/features/category_product/domain/usecases/get_all_category_product_.dart';
import 'package:manuk_pos/features/category_product/domain/usecases/get_category_product_.dart';
import 'package:manuk_pos/features/category_product/domain/usecases/update_category_product_.dart';

part 'category_product_event.dart';
part 'category_product_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategory getAllCategories;
  final GetCategoryById getCategoryById;
  final UpdateCategoryById updateCategoryById;
  final AddCategory addCategory;
  final DeleteCategory deleteCategory;

  CategoryBloc(
    this.getAllCategories,
    this.updateCategoryById,
    this.getCategoryById,
    this.addCategory,
    this.deleteCategory,
  ) : super(CategoryStateEmpty()) {
    on<GetAllCategoryEvent>(_onGetAllCategories);
    on<GetCategoryByIdEvent>(_onGetCategoryById);
    on<UpdateCategoryEvent>(_onUpdateCategoryById);
    on<AddCategoryEvent>(_onAddCategory);
    on<DeleteCategoryEvent>(_onDeleteCategory);
  }

  void _onGetAllCategories(
      GetAllCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryStateLoading());
    Either<Failures, List<Category>> result = await getAllCategories.call();
    result.fold(
      (failure) => emit(
          CategoryStateError("Failed to load categories: ${failure.message}")),
      (categories) => emit(CategoryStateLoaded(categories)),
    );
  }

  void _onGetCategoryById(
      GetCategoryByIdEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryStateLoading());
    Either<Failures, Category> result =
        await getCategoryById.call(event.categoryId);
    result.fold(
      (failure) => emit(
          CategoryStateError("Failed to load category: ${failure.message}")),
      (category) => emit(CategoryStateLoadedById(category)),
    );
  }

  void _onUpdateCategoryById(
      UpdateCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryStateLoading());
    Either<Failures, Category> result =
        await updateCategoryById.call(event.categoryId, event.category);
    result.fold(
      (failure) => emit(CategoryOperationFailure(
          "Category update failed: ${failure.message}")),
      (category) {
        emit(CategoryOperationSuccess("Category updated successfully"));
        add(GetAllCategoryEvent());
      },
    );
  }

  void _onAddCategory(
      AddCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryStateLoading());
    Either<Failures, Category> result = await addCategory.call(event.category);
    result.fold(
      (failure) => emit(CategoryOperationFailure(
          "Category creation failed: ${failure.message}")),
      (category) =>
          emit(CategoryOperationSuccess("Category created successfully")),
    );
  }

  void _onDeleteCategory(
      DeleteCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryStateLoading());
    Either<Failures, String> result =
        await deleteCategory.call(event.categoryId);
    result.fold(
      (failure) => emit(CategoryOperationFailure(
          "Category deletion failed: ${failure.message}")),
      (message) {
        emit(CategoryOperationSuccess("Category deleted successfully"));
        add(GetAllCategoryEvent());
      },
    );
  }
}
