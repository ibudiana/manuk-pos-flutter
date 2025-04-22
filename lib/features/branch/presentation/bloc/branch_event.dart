part of 'branch_bloc.dart';

abstract class BranchEvent extends Equatable {
  const BranchEvent();

  @override
  List<Object> get props => [];
}

class GetAllBranchEvent extends BranchEvent {
  const GetAllBranchEvent();

  @override
  List<Object> get props => [];
}

class GetBranchByIdEvent extends BranchEvent {
  final int BranchId;

  const GetBranchByIdEvent(this.BranchId);

  @override
  List<Object> get props => [BranchId];
}

class AddBranchEvent extends BranchEvent {
  final Branch branch;
  const AddBranchEvent(this.branch);

  @override
  List<Object> get props => [Branch];
}

class UpdateBranchEvent extends BranchEvent {
  final Branch branch;
  final int branchId;

  const UpdateBranchEvent(this.branchId, this.branch);
}

class DeleteBranchEvent extends BranchEvent {
  final int BranchId;

  const DeleteBranchEvent(this.BranchId);
}
