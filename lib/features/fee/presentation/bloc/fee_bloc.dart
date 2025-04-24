import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/fee/domain/entities/fee.dart';
import 'package:manuk_pos/features/fee/domain/usecases/add_fee.dart';
import 'package:manuk_pos/features/fee/domain/usecases/delete_fee.dart';
import 'package:manuk_pos/features/fee/domain/usecases/get_all_fee.dart';
import 'package:manuk_pos/features/fee/domain/usecases/get_fee.dart';
import 'package:manuk_pos/features/fee/domain/usecases/update_fee.dart';

part 'fee_event.dart';
part 'fee_state.dart';

class FeeBloc extends Bloc<FeeEvent, FeeState> {
  final GetAllFee getAllFees;
  final GetFeeById getFeeById;
  final UpdateFeeById updateFeeById;
  final AddFee addFee;
  final DeleteFee deleteFee;

  FeeBloc(
    this.getAllFees,
    this.updateFeeById,
    this.getFeeById,
    this.addFee,
    this.deleteFee,
  ) : super(FeeStateEmpty()) {
    on<GetAllFeeEvent>(_onGetAllFees);
    on<GetFeeByIdEvent>(_onGetFeeById);
    on<UpdateFeeEvent>(_onUpdateFeeById);
    on<AddFeeEvent>(_onAddFee);
    on<DeleteFeeEvent>(_onDeleteFee);
  }

  void _onGetAllFees(GetAllFeeEvent event, Emitter<FeeState> emit) async {
    emit(FeeStateLoading());
    Either<Failures, List<Fee>> result = await getAllFees.call();
    result.fold(
      (failure) =>
          emit(FeeStateError("Failed to load fees: ${failure.message}")),
      (fees) => emit(FeeStateLoaded(fees)),
    );
  }

  void _onGetFeeById(GetFeeByIdEvent event, Emitter<FeeState> emit) async {
    emit(FeeStateLoading());
    Either<Failures, Fee> result = await getFeeById.call(event.feeId);
    result.fold(
      (failure) =>
          emit(FeeStateError("Failed to load fee: ${failure.message}")),
      (fee) => emit(FeeStateLoadedById(fee)),
    );
  }

  void _onUpdateFeeById(UpdateFeeEvent event, Emitter<FeeState> emit) async {
    emit(FeeStateLoading());
    Either<Failures, Fee> result =
        await updateFeeById.call(event.feeId, event.fee);
    result.fold(
      (failure) =>
          emit(FeeOperationFailure("Fee update failed: ${failure.message}")),
      (fee) {
        emit(FeeOperationSuccess("Fee updated successfully"));
        add(GetAllFeeEvent());
      },
    );
  }

  void _onAddFee(AddFeeEvent event, Emitter<FeeState> emit) async {
    emit(FeeStateLoading());
    Either<Failures, Fee> result = await addFee.call(event.fee);
    result.fold(
      (failure) =>
          emit(FeeOperationFailure("Fee creation failed: ${failure.message}")),
      (fee) => emit(FeeOperationSuccess("Fee created successfully")),
    );
  }

  void _onDeleteFee(DeleteFeeEvent event, Emitter<FeeState> emit) async {
    emit(FeeStateLoading());
    Either<Failures, String> result = await deleteFee.call(event.feeId);
    result.fold(
      (failure) =>
          emit(FeeOperationFailure("Fee deletion failed: ${failure.message}")),
      (message) {
        emit(FeeOperationSuccess("Fee deleted successfully"));
        add(GetAllFeeEvent());
      },
    );
  }
}
