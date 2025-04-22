import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/features/branch/domain/entities/branch.dart';
import 'package:manuk_pos/features/branch/domain/usecases/get_all_branches.dart';
import 'package:manuk_pos/features/branch/domain/usecases/update_branch.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  final GetAllBranches getAllBranches;
  final UpdateBranch updateBranch;

  BranchBloc(this.getAllBranches, this.updateBranch)
      : super(BranchStateEmpty()) {
    on<GetAllBranchEvent>(_onGetAllBranches);
    on<UpdateBranchEvent>(_onUpdateBranch);
  }

  void _onGetAllBranches(
      GetAllBranchEvent event, Emitter<BranchState> emit) async {
    emit(BranchStateLoading());
    final result = await getAllBranches.call();

    result.fold(
      (failure) => emit(BranchStateError(failure.message)),
      (branches) => emit(BranchStateLoaded(branches)),
    );
  }

  void _onUpdateBranch(
      UpdateBranchEvent event, Emitter<BranchState> emit) async {
    emit(BranchStateLoading());
    final result = await updateBranch.call(event.branchId, event.branch);
    result.fold(
      (failure) => emit(
          BranchOperationFailure("Branch update failed: ${failure.message}")),
      (branch) {
        emit(BranchOperationSuccess("Branch updated successfully"));
        add(GetAllBranchEvent());
      },
    );
  }
}
