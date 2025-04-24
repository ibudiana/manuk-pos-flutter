part of 'category_product_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetAllCategoryEvent extends CategoryEvent {
  const GetAllCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryByIdEvent extends CategoryEvent {
  final int categoryId;

  const GetCategoryByIdEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class AddCategoryEvent extends CategoryEvent {
  final Category category;

  const AddCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class UpdateCategoryEvent extends CategoryEvent {
  final int categoryId;
  final Category category;

  const UpdateCategoryEvent(this.categoryId, this.category);

  @override
  List<Object> get props => [categoryId, category];
}

class DeleteCategoryEvent extends CategoryEvent {
  final int categoryId;

  const DeleteCategoryEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
