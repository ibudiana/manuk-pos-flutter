import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/transaction/domain/entities/transaction.dart';
import 'package:manuk_pos/features/transaction/domain/usecases/add_transaction.dart';
import 'package:manuk_pos/features/transaction/domain/usecases/delete_transaction.dart';
import 'package:manuk_pos/features/transaction/domain/usecases/get_all_transaction.dart';
import 'package:manuk_pos/features/transaction/domain/usecases/get_transaction.dart';
import 'package:manuk_pos/features/transaction/domain/usecases/update_transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetAllTransaction getAllTransaction;
  final GetTransactionById getTransactionById;
  final UpdateTransactionById updateTransactionById;
  final AddTransaction addTransaction;
  final DeleteTransaction deleteTransaction;

  TransactionBloc(
    this.getAllTransaction,
    this.updateTransactionById,
    this.getTransactionById,
    this.addTransaction,
    this.deleteTransaction,
  ) : super(TransactionStateEmpty()) {
    on<GetAllTransactionEvent>(_onGetAllTransaction);
    on<GetTransactionByIdEvent>(_onGetTransactionById);
    on<UpdateTransactionEvent>(_onUpdateTransactionById);
    on<AddTransactionEvent>(_onAddTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
  }

  void _onGetAllTransaction(
      GetAllTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionStateLoading());
    Either<Failures, List<Transaction>> result = await getAllTransaction.call();
    result.fold(
      (failure) => emit(TransactionStateError(
          "Failed to load transactions: ${failure.message}")),
      (transactions) => emit(TransactionStateLoaded(transactions)),
    );
  }

  void _onGetTransactionById(
      GetTransactionByIdEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionStateLoading());
    Either<Failures, Transaction> result =
        await getTransactionById.call(event.transactionId);
    result.fold(
      (failure) => emit(TransactionStateError(
          "Failed to load transaction: ${failure.message}")),
      (transaction) => emit(TransactionStateLoadedById(transaction)),
    );
  }

  void _onUpdateTransactionById(
      UpdateTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionStateLoading());
    Either<Failures, Transaction> result = await updateTransactionById.call(
        event.transactionId, event.transaction);
    result.fold(
      (failure) => emit(TransactionOperationFailure(
          "Transaction update failed: ${failure.message}")),
      (_) {
        emit(TransactionOperationSuccess("Transaction updated successfully"));
        add(GetAllTransactionEvent());
      },
    );
  }

  void _onAddTransaction(
      AddTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionStateLoading());
    Either<Failures, Transaction> result =
        await addTransaction.call(event.transaction);
    result.fold(
      (failure) => emit(TransactionOperationFailure(
          "Transaction creation failed: ${failure.message}")),
      (_) =>
          emit(TransactionOperationSuccess("Transaction created successfully")),
    );
  }

  void _onDeleteTransaction(
      DeleteTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionStateLoading());
    Either<Failures, String> result =
        await deleteTransaction.call(event.transactionId);
    result.fold(
      (failure) => emit(TransactionOperationFailure(
          "Transaction deletion failed: ${failure.message}")),
      (_) {
        emit(TransactionOperationSuccess("Transaction deleted successfully"));
        add(GetAllTransactionEvent());
      },
    );
  }
}
