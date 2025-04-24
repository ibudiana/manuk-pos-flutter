part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetAllProductEvent extends ProductEvent {
  const GetAllProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductByIdEvent extends ProductEvent {
  final int productId;

  const GetProductByIdEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class AddProductEvent extends ProductEvent {
  final Product product;

  const AddProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateProductEvent extends ProductEvent {
  final int productId;
  final Product product;

  const UpdateProductEvent(this.productId, this.product);

  @override
  List<Object> get props => [productId, product];
}

class DeleteProductEvent extends ProductEvent {
  final int productId;

  const DeleteProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
