part of 'loan_bloc.dart';

abstract class LoanState extends Equatable {
  const LoanState();

  @override
  List<Object> get props => [];
}

class LoanStateEmpty extends LoanState {}

class LoanStateLoading extends LoanState {}

class LoanStateError extends LoanState {
  final String message;

  const LoanStateError(this.message);

  @override
  List<Object> get props => [message];
}

class LoanStateLoaded extends LoanState {
  final List<Loan> loans;

  const LoanStateLoaded(this.loans);

  @override
  List<Object> get props => [loans];
}

class LoanStateLoadedById extends LoanState {
  final Loan loan;

  const LoanStateLoadedById(this.loan);

  @override
  List<Object> get props => [loan];
}

class LoanDeleteSuccess extends LoanState {
  final String message;

  const LoanDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class LoanOperationSuccess extends LoanState {
  final String message;

  const LoanOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class LoanOperationFailure extends LoanState {
  final String message;

  const LoanOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
