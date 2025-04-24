import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/supplier/domain/entities/supplier.dart';
import 'package:manuk_pos/features/supplier/domain/usecases/add_supplier.dart';
import 'package:manuk_pos/features/supplier/domain/usecases/delete_supplier.dart';
import 'package:manuk_pos/features/supplier/domain/usecases/get_all_supplier.dart';
import 'package:manuk_pos/features/supplier/domain/usecases/get_supplier.dart';
import 'package:manuk_pos/features/supplier/domain/usecases/update_supplier.dart';

part 'supplier_event.dart';
part 'supplier_state.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  final GetAllSupplier getAllSuppliers;
  final GetSupplierById getSupplierById;
  final UpdateSupplierById updateSupplierById;
  final AddSupplier addSupplier;
  final DeleteSupplier deleteSupplier;

  SupplierBloc(
    this.getAllSuppliers,
    this.updateSupplierById,
    this.getSupplierById,
    this.addSupplier,
    this.deleteSupplier,
  ) : super(SupplierStateEmpty()) {
    on<GetAllSupplierEvent>(_onGetAllSuppliers);
    on<GetSupplierByIdEvent>(_onGetSupplierById);
    on<UpdateSupplierEvent>(_onUpdateSupplierById);
    on<AddSupplierEvent>(_onAddSupplier);
    on<DeleteSupplierEvent>(_onDeleteSupplier);
  }

  void _onGetAllSuppliers(
      GetAllSupplierEvent event, Emitter<SupplierState> emit) async {
    emit(SupplierStateLoading());
    Either<Failures, List<Supplier>> result = await getAllSuppliers.call();
    result.fold(
      (failure) => emit(
          SupplierStateError("Failed to load suppliers: ${failure.message}")),
      (suppliers) => emit(SupplierStateLoaded(suppliers)),
    );
  }

  void _onGetSupplierById(
      GetSupplierByIdEvent event, Emitter<SupplierState> emit) async {
    emit(SupplierStateLoading());
    Either<Failures, Supplier> result =
        await getSupplierById.call(event.supplierId);
    result.fold(
      (failure) => emit(
          SupplierStateError("Failed to load supplier: ${failure.message}")),
      (supplier) => emit(SupplierStateLoadedById(supplier)),
    );
  }

  void _onUpdateSupplierById(
      UpdateSupplierEvent event, Emitter<SupplierState> emit) async {
    emit(SupplierStateLoading());
    Either<Failures, Supplier> result =
        await updateSupplierById.call(event.supplierId, event.supplier);
    result.fold(
      (failure) => emit(SupplierOperationFailure(
          "Supplier update failed: ${failure.message}")),
      (supplier) {
        emit(SupplierOperationSuccess("Supplier updated successfully"));
        add(GetAllSupplierEvent());
      },
    );
  }

  void _onAddSupplier(
      AddSupplierEvent event, Emitter<SupplierState> emit) async {
    emit(SupplierStateLoading());
    Either<Failures, Supplier> result = await addSupplier.call(event.supplier);
    result.fold(
      (failure) => emit(SupplierOperationFailure(
          "Supplier creation failed: ${failure.message}")),
      (supplier) =>
          emit(SupplierOperationSuccess("Supplier created successfully")),
    );
  }

  void _onDeleteSupplier(
      DeleteSupplierEvent event, Emitter<SupplierState> emit) async {
    emit(SupplierStateLoading());
    Either<Failures, String> result =
        await deleteSupplier.call(event.supplierId);
    result.fold(
      (failure) => emit(SupplierOperationFailure(
          "Supplier deletion failed: ${failure.message}")),
      (message) {
        emit(SupplierOperationSuccess("Supplier deleted successfully"));
        add(GetAllSupplierEvent());
      },
    );
  }
}
