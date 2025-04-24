import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/loan/domain/entities/loan.dart';
import 'package:manuk_pos/features/loan/domain/usecases/add_loan.dart';
import 'package:manuk_pos/features/loan/domain/usecases/delete_loan.dart';
import 'package:manuk_pos/features/loan/domain/usecases/get_all_loan.dart';
import 'package:manuk_pos/features/loan/domain/usecases/get_loan.dart';
import 'package:manuk_pos/features/loan/domain/usecases/update_loan.dart';

part 'loan_event.dart';
part 'loan_state.dart';

class LoanBloc extends Bloc<LoanEvent, LoanState> {
  final GetAllLoan getAllLoans;
  final GetLoanById getLoanById;
  final UpdateLoanById updateLoanById;
  final AddLoan addLoan;
  final DeleteLoan deleteLoan;

  LoanBloc(
    this.getAllLoans,
    this.updateLoanById,
    this.getLoanById,
    this.addLoan,
    this.deleteLoan,
  ) : super(LoanStateEmpty()) {
    on<GetAllLoanEvent>(_onGetAllLoans);
    on<GetLoanByIdEvent>(_onGetLoanById);
    on<UpdateLoanEvent>(_onUpdateLoanById);
    on<AddLoanEvent>(_onAddLoan);
    on<DeleteLoanEvent>(_onDeleteLoan);
  }

  void _onGetAllLoans(GetAllLoanEvent event, Emitter<LoanState> emit) async {
    emit(LoanStateLoading());
    Either<Failures, List<Loan>> result = await getAllLoans.call();
    result.fold(
      (failure) =>
          emit(LoanStateError("Failed to load loans: ${failure.message}")),
      (loans) => emit(LoanStateLoaded(loans)),
    );
  }

  void _onGetLoanById(GetLoanByIdEvent event, Emitter<LoanState> emit) async {
    emit(LoanStateLoading());
    Either<Failures, Loan> result = await getLoanById.call(event.loanId);
    result.fold(
      (failure) =>
          emit(LoanStateError("Failed to load loan: ${failure.message}")),
      (loan) => emit(LoanStateLoadedById(loan)),
    );
  }

  void _onUpdateLoanById(UpdateLoanEvent event, Emitter<LoanState> emit) async {
    emit(LoanStateLoading());
    Either<Failures, Loan> result =
        await updateLoanById.call(event.loanId, event.loan);
    result.fold(
      (failure) =>
          emit(LoanOperationFailure("Loan update failed: ${failure.message}")),
      (loan) {
        emit(LoanOperationSuccess("Loan updated successfully"));
        add(GetAllLoanEvent());
      },
    );
  }

  void _onAddLoan(AddLoanEvent event, Emitter<LoanState> emit) async {
    emit(LoanStateLoading());
    Either<Failures, Loan> result = await addLoan.call(event.loan);
    result.fold(
      (failure) => emit(
          LoanOperationFailure("Loan creation failed: ${failure.message}")),
      (loan) => emit(LoanOperationSuccess("Loan created successfully")),
    );
  }

  void _onDeleteLoan(DeleteLoanEvent event, Emitter<LoanState> emit) async {
    emit(LoanStateLoading());
    Either<Failures, String> result = await deleteLoan.call(event.loanId);
    result.fold(
      (failure) => emit(
          LoanOperationFailure("Loan deletion failed: ${failure.message}")),
      (message) {
        emit(LoanOperationSuccess("Loan deleted successfully"));
        add(GetAllLoanEvent());
      },
    );
  }
}
