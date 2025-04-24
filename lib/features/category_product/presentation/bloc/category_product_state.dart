part of 'category_product_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryStateEmpty extends CategoryState {}

class CategoryStateLoading extends CategoryState {}

class CategoryStateError extends CategoryState {
  final String message;

  const CategoryStateError(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryStateLoaded extends CategoryState {
  final List<Category> categories;

  const CategoryStateLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryStateLoadedById extends CategoryState {
  final Category category;

  const CategoryStateLoadedById(this.category);

  @override
  List<Object> get props => [category];
}

class CategoryDeleteSuccess extends CategoryState {
  final String message;

  const CategoryDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryOperationSuccess extends CategoryState {
  final String message;

  const CategoryOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryOperationFailure extends CategoryState {
  final String message;

  const CategoryOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
