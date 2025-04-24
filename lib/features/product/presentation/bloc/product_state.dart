part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductStateEmpty extends ProductState {}

class ProductStateLoading extends ProductState {}

class ProductStateError extends ProductState {
  final String message;

  const ProductStateError(this.message);

  @override
  List<Object> get props => [message];
}

class ProductStateLoaded extends ProductState {
  final List<Product> products;

  const ProductStateLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductStateLoadedById extends ProductState {
  final Product product;

  const ProductStateLoadedById(this.product);

  @override
  List<Object> get props => [product];
}

class ProductDeleteSuccess extends ProductState {
  final String message;

  const ProductDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ProductOperationSuccess extends ProductState {
  final String message;

  const ProductOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ProductOperationFailure extends ProductState {
  final String message;

  const ProductOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
