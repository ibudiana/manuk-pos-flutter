part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class GetAllTransactionEvent extends TransactionEvent {
  const GetAllTransactionEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionByIdEvent extends TransactionEvent {
  final int transactionId;

  const GetTransactionByIdEvent(this.transactionId);

  @override
  List<Object> get props => [transactionId];
}

class AddTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  const AddTransactionEvent(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class UpdateTransactionEvent extends TransactionEvent {
  final int transactionId;
  final Transaction transaction;

  const UpdateTransactionEvent(this.transactionId, this.transaction);

  @override
  List<Object> get props => [transactionId, transaction];
}

class DeleteTransactionEvent extends TransactionEvent {
  final int transactionId;

  const DeleteTransactionEvent(this.transactionId);

  @override
  List<Object> get props => [transactionId];
}
