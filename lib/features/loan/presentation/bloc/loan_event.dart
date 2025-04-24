part of 'loan_bloc.dart';

abstract class LoanEvent extends Equatable {
  const LoanEvent();

  @override
  List<Object> get props => [];
}

class GetAllLoanEvent extends LoanEvent {
  const GetAllLoanEvent();

  @override
  List<Object> get props => [];
}

class GetLoanByIdEvent extends LoanEvent {
  final int loanId;

  const GetLoanByIdEvent(this.loanId);

  @override
  List<Object> get props => [loanId];
}

class AddLoanEvent extends LoanEvent {
  final Loan loan;

  const AddLoanEvent(this.loan);

  @override
  List<Object> get props => [loan];
}

class UpdateLoanEvent extends LoanEvent {
  final int loanId;
  final Loan loan;

  const UpdateLoanEvent(this.loanId, this.loan);

  @override
  List<Object> get props => [loanId, loan];
}

class DeleteLoanEvent extends LoanEvent {
  final int loanId;

  const DeleteLoanEvent(this.loanId);

  @override
  List<Object> get props => [loanId];
}
