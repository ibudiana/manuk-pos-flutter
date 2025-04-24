part of 'supplier_bloc.dart';

abstract class SupplierState extends Equatable {
  const SupplierState();

  @override
  List<Object> get props => [];
}

class SupplierStateEmpty extends SupplierState {}

class SupplierStateLoading extends SupplierState {}

class SupplierStateError extends SupplierState {
  final String message;

  const SupplierStateError(this.message);

  @override
  List<Object> get props => [message];
}

class SupplierStateLoaded extends SupplierState {
  final List<Supplier> suppliers;

  const SupplierStateLoaded(this.suppliers);

  @override
  List<Object> get props => [suppliers];
}

class SupplierStateLoadedById extends SupplierState {
  final Supplier supplier;

  const SupplierStateLoadedById(this.supplier);

  @override
  List<Object> get props => [supplier];
}

class SupplierDeleteSuccess extends SupplierState {
  final String message;

  const SupplierDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SupplierOperationSuccess extends SupplierState {
  final String message;

  const SupplierOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SupplierOperationFailure extends SupplierState {
  final String message;

  const SupplierOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
