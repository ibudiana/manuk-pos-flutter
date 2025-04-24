import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/product/domain/entities/product.dart';
import 'package:manuk_pos/features/product/domain/usecases/add_product.dart';
import 'package:manuk_pos/features/product/domain/usecases/delete_product.dart';
import 'package:manuk_pos/features/product/domain/usecases/get_all_product.dart';
import 'package:manuk_pos/features/product/domain/usecases/get_product.dart';
import 'package:manuk_pos/features/product/domain/usecases/update_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProduct getAllProducts;
  final GetProductById getProductById;
  final UpdateProductById updateProductById;
  final AddProduct addProduct;
  final DeleteProduct deleteProduct;

  ProductBloc(
    this.getAllProducts,
    this.updateProductById,
    this.getProductById,
    this.addProduct,
    this.deleteProduct,
  ) : super(ProductStateEmpty()) {
    on<GetAllProductEvent>(_onGetAllProducts);
    on<GetProductByIdEvent>(_onGetProductById);
    on<UpdateProductEvent>(_onUpdateProductById);
    on<AddProductEvent>(_onAddProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  void _onGetAllProducts(
      GetAllProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductStateLoading());
    Either<Failures, List<Product>> result = await getAllProducts.call();
    result.fold(
      (failure) => emit(
          ProductStateError("Failed to load products: ${failure.message}")),
      (products) => emit(ProductStateLoaded(products)),
    );
  }

  void _onGetProductById(
      GetProductByIdEvent event, Emitter<ProductState> emit) async {
    emit(ProductStateLoading());
    Either<Failures, Product> result =
        await getProductById.call(event.productId);
    result.fold(
      (failure) =>
          emit(ProductStateError("Failed to load product: ${failure.message}")),
      (product) => emit(ProductStateLoadedById(product)),
    );
  }

  void _onUpdateProductById(
      UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductStateLoading());
    Either<Failures, Product> result =
        await updateProductById.call(event.productId, event.product);
    result.fold(
      (failure) => emit(
          ProductOperationFailure("Product update failed: ${failure.message}")),
      (product) {
        emit(ProductOperationSuccess("Product updated successfully"));
        add(GetAllProductEvent());
      },
    );
  }

  void _onAddProduct(AddProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductStateLoading());
    Either<Failures, Product> result = await addProduct.call(event.product);
    result.fold(
      (failure) => emit(ProductOperationFailure(
          "Product creation failed: ${failure.message}")),
      (product) =>
          emit(ProductOperationSuccess("Product created successfully")),
    );
  }

  void _onDeleteProduct(
      DeleteProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductStateLoading());
    Either<Failures, String> result = await deleteProduct.call(event.productId);
    result.fold(
      (failure) => emit(ProductOperationFailure(
          "Product deletion failed: ${failure.message}")),
      (message) {
        emit(ProductOperationSuccess("Product deleted successfully"));
        add(GetAllProductEvent());
      },
    );
  }
}
