import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/branch/domain/entities/branch.dart';
import 'package:manuk_pos/features/branch/domain/usecases/add_branch.dart';
import 'package:manuk_pos/features/branch/domain/usecases/delete_branch.dart';
import 'package:manuk_pos/features/branch/domain/usecases/get_all_branch.dart';
import 'package:manuk_pos/features/branch/domain/usecases/get_branch.dart';
import 'package:manuk_pos/features/branch/domain/usecases/update_branch.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  final GetAllBranches getAllBranchs;
  final GetBranchById getBranchById;
  final UpdateBranchById updateBranchById;
  final AddBranch addBranch;
  final DeleteBranch deleteBranch;

  BranchBloc(this.getAllBranchs, this.updateBranchById, this.getBranchById,
      this.addBranch, this.deleteBranch)
      : super(BranchStateEmpty()) {
    on<GetAllBranchEvent>(_onGetAllBranchs);
    on<GetBranchByIdEvent>(_onGetBranchById);
    on<UpdateBranchEvent>(_onUpdateBranchById);
    on<AddBranchEvent>(_onAddBranch);
    on<DeleteBranchEvent>(_onDeleteBranch);
  }

  void _onGetAllBranchs(
      GetAllBranchEvent event, Emitter<BranchState> emit) async {
    emit(BranchStateLoading());
    Either<Failures, List<Branch>> result = await getAllBranchs.call();
    result.fold(
      (failure) =>
          emit(BranchStateError("Failed to load Branchs: ${failure.message}")),
      (Branchs) => emit(BranchStateLoaded(Branchs)),
    );
  }

  void _onGetBranchById(
      GetBranchByIdEvent event, Emitter<BranchState> emit) async {
    emit(BranchStateLoading());
    Either<Failures, Branch> result = await getBranchById.call(event.branchId);
    result.fold(
      (failure) =>
          emit(BranchStateError("Failed to load Branch: ${failure.message}")),
      (branch) => emit(BranchStateLoadedById(branch)),
    );
  }

  void _onUpdateBranchById(
      UpdateBranchEvent event, Emitter<BranchState> emit) async {
    emit(BranchStateLoading());
    Either<Failures, Branch> result =
        await updateBranchById.call(event.branchId, event.branch);
    result.fold(
      (failure) => emit(
          BranchOperationFailure("Branch updated Failed: ${failure.message}")),
      (branch) {
        emit(BranchOperationSuccess("Branch updated successfully"));
        add(GetAllBranchEvent());
      },
    );
  }

  void _onAddBranch(AddBranchEvent event, Emitter<BranchState> emit) async {
    emit(BranchStateLoading());
    Either<Failures, Branch> result = await addBranch.call(event.branch);
    result.fold(
      (failure) => emit(
          BranchOperationFailure("Branch create failed: ${failure.message}")),
      (branch) => emit(BranchOperationSuccess("Branch created successfully")),
    );
  }

  void _onDeleteBranch(
      DeleteBranchEvent event, Emitter<BranchState> emit) async {
    emit(BranchStateLoading());
    Either<Failures, String> result = await deleteBranch.call(event.branchId);
    result.fold(
      (failure) => emit(
          BranchOperationFailure("Branch deleted Failed: ${failure.message}")),
      (branch) {
        emit(BranchOperationSuccess("Branch delete successfully"));
        add(GetAllBranchEvent());
      },
    );
  }
}

// class BranchBloc extends Bloc<BranchEvent, BranchState> {
//   final GetAllBranches getAllBranches;
//   final UpdateBranch updateBranch;

//   BranchBloc(this.getAllBranches, this.updateBranch)
//       : super(BranchStateEmpty()) {
//     on<GetAllBranchEvent>(_onGetAllBranches);
//     on<UpdateBranchEvent>(_onUpdateBranchById);
//   }

//   void _onGetAllBranches(
//       GetAllBranchEvent event, Emitter<BranchState> emit) async {
//     emit(BranchStateLoading());
//     final result = await getAllBranches.call();

//     result.fold(
//       (failure) => emit(BranchStateError(failure.message)),
//       (branches) => emit(BranchStateLoaded(branches)),
//     );
//   }

//   // void _onGetBranchById(GetBranchByIdEvent event, Emitter<BranchState> emit) async {
//   //   emit(BranchStateLoading());
//   //   Either<Failures, Branch> result = await getBranchById.call(event.BranchId);
//   //   result.fold(
//   //     (failure) =>
//   //         emit(BranchStateError("Failed to load Branch: ${failure.message}")),
//   //     (branch) => emit(BranchStateLoadedById(Branch)),
//   //   );
//   // }

//   void _onUpdateBranchById(
//       UpdateBranchEvent event, Emitter<BranchState> emit) async {
//     emit(BranchStateLoading());
//     final result = await updateBranch.call(event.branchId, event.branch);
//     result.fold(
//       (failure) => emit(
//           BranchOperationFailure("Branch update failed: ${failure.message}")),
//       (branch) {
//         emit(BranchOperationSuccess("Branch updated successfully"));
//         add(GetAllBranchEvent());
//       },
//     );
//   }

//   // void _onAddBranch(AddBranchEvent event, Emitter<BranchState> emit) async {
//   //   emit(BranchStateLoading());
//   //   Either<Failures, Branch> result = await addBranch.call(event.Branch);
//   //   result.fold(
//   //     (failure) =>
//   //         emit(BranchOperationFailure("Branch create failed: ${failure.message}")),
//   //     (Branch) => emit(BranchOperationSuccess("Branch created successfully")),
//   //   );
//   // }

//   // void _onDeleteBranch(DeleteBranchEvent event, Emitter<BranchState> emit) async {
//   //   emit(BranchStateLoading());
//   //   Either<Failures, String> result = await deleteBranch.call(event.BranchId);
//   //   result.fold(
//   //     (failure) =>
//   //         emit(BranchOperationFailure("Branch deleted Failed: ${failure.message}")),
//   //     (Branch) {
//   //       emit(BranchOperationSuccess("Branch delete successfully"));
//   //       add(GetAllBranchsEvent());
//   //     },
//   //   );
//   // }
// }
