part of 'supplier_bloc.dart';

abstract class SupplierEvent extends Equatable {
  const SupplierEvent();

  @override
  List<Object> get props => [];
}

class GetAllSupplierEvent extends SupplierEvent {
  const GetAllSupplierEvent();

  @override
  List<Object> get props => [];
}

class GetSupplierByIdEvent extends SupplierEvent {
  final int supplierId;

  const GetSupplierByIdEvent(this.supplierId);

  @override
  List<Object> get props => [supplierId];
}

class AddSupplierEvent extends SupplierEvent {
  final Supplier supplier;

  const AddSupplierEvent(this.supplier);

  @override
  List<Object> get props => [supplier];
}

class UpdateSupplierEvent extends SupplierEvent {
  final int supplierId;
  final Supplier supplier;

  const UpdateSupplierEvent(this.supplierId, this.supplier);

  @override
  List<Object> get props => [supplierId, supplier];
}

class DeleteSupplierEvent extends SupplierEvent {
  final int supplierId;

  const DeleteSupplierEvent(this.supplierId);

  @override
  List<Object> get props => [supplierId];
}
