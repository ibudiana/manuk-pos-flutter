import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/tax/domain/entities/tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/add_tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/delete_tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/get_all_tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/get_tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/update_tax.dart';

part 'tax_event.dart';
part 'tax_state.dart';

class TaxBloc extends Bloc<TaxEvent, TaxState> {
  final GetAllTax getAllTax;
  final GetTaxById getTaxById;
  final UpdateTaxById updateTaxById;
  final AddTax addTax;
  final DeleteTax deleteTax;

  TaxBloc(
    this.getAllTax,
    this.updateTaxById,
    this.getTaxById,
    this.addTax,
    this.deleteTax,
  ) : super(TaxStateEmpty()) {
    on<GetAllTaxEvent>(_onGetAllTax);
    on<GetTaxByIdEvent>(_onGetTaxById);
    on<UpdateTaxEvent>(_onUpdateTaxById);
    on<AddTaxEvent>(_onAddTax);
    on<DeleteTaxEvent>(_onDeleteTax);
  }

  void _onGetAllTax(GetAllTaxEvent event, Emitter<TaxState> emit) async {
    emit(TaxStateLoading());
    Either<Failures, List<Tax>> result = await getAllTax.call();
    result.fold(
      (failure) =>
          emit(TaxStateError("Failed to load tax: ${failure.message}")),
      (taxes) => emit(TaxStateLoaded(taxes)),
    );
  }

  void _onGetTaxById(GetTaxByIdEvent event, Emitter<TaxState> emit) async {
    emit(TaxStateLoading());
    Either<Failures, Tax> result = await getTaxById.call(event.taxId);
    result.fold(
      (failure) =>
          emit(TaxStateError("Failed to load tax: ${failure.message}")),
      (tax) => emit(TaxStateLoadedById(tax)),
    );
  }

  void _onUpdateTaxById(UpdateTaxEvent event, Emitter<TaxState> emit) async {
    emit(TaxStateLoading());
    Either<Failures, Tax> result =
        await updateTaxById.call(event.taxId, event.tax);
    result.fold(
      (failure) =>
          emit(TaxOperationFailure("Tax update failed: ${failure.message}")),
      (tax) {
        emit(TaxOperationSuccess("Tax updated successfully"));
        add(GetAllTaxEvent());
      },
    );
  }

  void _onAddTax(AddTaxEvent event, Emitter<TaxState> emit) async {
    emit(TaxStateLoading());
    Either<Failures, Tax> result = await addTax.call(event.tax);
    result.fold(
      (failure) =>
          emit(TaxOperationFailure("Tax creation failed: ${failure.message}")),
      (tax) => emit(TaxOperationSuccess("Tax created successfully")),
    );
  }

  void _onDeleteTax(DeleteTaxEvent event, Emitter<TaxState> emit) async {
    emit(TaxStateLoading());
    Either<Failures, String> result = await deleteTax.call(event.taxId);
    result.fold(
      (failure) =>
          emit(TaxOperationFailure("Tax deletion failed: ${failure.message}")),
      (message) {
        emit(TaxOperationSuccess("Tax deleted successfully"));
        add(GetAllTaxEvent());
      },
    );
  }
}
