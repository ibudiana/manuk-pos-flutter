import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/discount/domain/entities/discount.dart';
import 'package:manuk_pos/features/discount/domain/usecases/add_discount.dart';
import 'package:manuk_pos/features/discount/domain/usecases/delete_discount.dart';
import 'package:manuk_pos/features/discount/domain/usecases/get_all_discount.dart';
import 'package:manuk_pos/features/discount/domain/usecases/get_discount.dart';
import 'package:manuk_pos/features/discount/domain/usecases/update_discount.dart';

part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final GetAllDiscounts getAllDiscounts;
  final GetDiscountById getDiscountById;
  final UpdateDiscountById updateDiscountById;
  final AddDiscount addDiscount;
  final DeleteDiscount deleteDiscount;

  DiscountBloc(this.getAllDiscounts, this.updateDiscountById,
      this.getDiscountById, this.addDiscount, this.deleteDiscount)
      : super(DiscountStateEmpty()) {
    on<GetAllDiscountEvent>(_onGetAllDiscounts);
    on<GetDiscountByIdEvent>(_onGetDiscountById);
    on<UpdateDiscountEvent>(_onUpdateDiscountById);
    on<AddDiscountEvent>(_onAddDiscount);
    on<DeleteDiscountEvent>(_onDeleteDiscount);
  }

  void _onGetAllDiscounts(
      GetAllDiscountEvent event, Emitter<DiscountState> emit) async {
    emit(DiscountStateLoading());
    Either<Failures, List<Discount>> result = await getAllDiscounts.call();
    result.fold(
      (failure) => emit(
          DiscountStateError("Failed to load discounts: ${failure.message}")),
      (discounts) => emit(DiscountStateLoaded(discounts)),
    );
  }

  void _onGetDiscountById(
      GetDiscountByIdEvent event, Emitter<DiscountState> emit) async {
    emit(DiscountStateLoading());
    Either<Failures, Discount> result =
        await getDiscountById.call(event.discountId);
    result.fold(
      (failure) => emit(
          DiscountStateError("Failed to load discount: ${failure.message}")),
      (discount) => emit(DiscountStateLoadedById(discount)),
    );
  }

  void _onUpdateDiscountById(
      UpdateDiscountEvent event, Emitter<DiscountState> emit) async {
    emit(DiscountStateLoading());
    Either<Failures, Discount> result =
        await updateDiscountById.call(event.discountId, event.discount);
    result.fold(
      (failure) => emit(DiscountOperationFailure(
          "Discount update failed: ${failure.message}")),
      (discount) {
        emit(DiscountOperationSuccess("Discount updated successfully"));
        add(GetAllDiscountEvent());
      },
    );
  }

  void _onAddDiscount(
      AddDiscountEvent event, Emitter<DiscountState> emit) async {
    emit(DiscountStateLoading());
    Either<Failures, Discount> result = await addDiscount.call(event.discount);
    result.fold(
      (failure) => emit(DiscountOperationFailure(
          "Discount creation failed: ${failure.message}")),
      (discount) =>
          emit(DiscountOperationSuccess("Discount created successfully")),
    );
  }

  void _onDeleteDiscount(
      DeleteDiscountEvent event, Emitter<DiscountState> emit) async {
    emit(DiscountStateLoading());
    Either<Failures, String> result =
        await deleteDiscount.call(event.discountId);
    result.fold(
      (failure) => emit(DiscountOperationFailure(
          "Discount deletion failed: ${failure.message}")),
      (message) {
        emit(DiscountOperationSuccess("Discount deleted successfully"));
        add(GetAllDiscountEvent());
      },
    );
  }
}
