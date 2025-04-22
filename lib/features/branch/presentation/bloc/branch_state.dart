part of 'branch_bloc.dart';

abstract class BranchState extends Equatable {
  const BranchState();

  @override
  List<Object> get props => [];
}

class BranchStateEmpty extends BranchState {}

class BranchStateLoading extends BranchState {}

class BranchStateError extends BranchState {
  final String message;

  const BranchStateError(this.message);

  @override
  List<Object> get props => [message];
}

class BranchStateLoaded extends BranchState {
  final List<Branch> branches;

  const BranchStateLoaded(this.branches);

  @override
  List<Object> get props => [branches];
}

class BranchStateLoadedById extends BranchState {
  final Branch branch;

  const BranchStateLoadedById(this.branch);

  @override
  List<Object> get props => [branch];
}

class BranchDeleteSuccess extends BranchState {
  final String message;

  const BranchDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class BranchOperationSuccess extends BranchState {
  final String message;

  const BranchOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class BranchOperationFailure extends BranchState {
  final String message;

  const BranchOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
