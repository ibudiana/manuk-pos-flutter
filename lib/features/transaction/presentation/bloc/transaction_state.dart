part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionStateEmpty extends TransactionState {}

class TransactionStateLoading extends TransactionState {}

class TransactionStateError extends TransactionState {
  final String message;

  const TransactionStateError(this.message);

  @override
  List<Object> get props => [message];
}

class TransactionStateLoaded extends TransactionState {
  final List<Transaction> transactions;

  const TransactionStateLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TransactionStateLoadedById extends TransactionState {
  final Transaction transaction;

  const TransactionStateLoadedById(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class TransactionDeleteSuccess extends TransactionState {
  final String message;

  const TransactionDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TransactionOperationSuccess extends TransactionState {
  final String message;

  const TransactionOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TransactionOperationFailure extends TransactionState {
  final String message;

  const TransactionOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
