import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/role/domain/entities/role.dart';
import 'package:manuk_pos/features/role/domain/usecases/add_role.dart';
import 'package:manuk_pos/features/role/domain/usecases/delete_role.dart';
import 'package:manuk_pos/features/role/domain/usecases/get_all_role.dart';
import 'package:manuk_pos/features/role/domain/usecases/get_role.dart';
import 'package:manuk_pos/features/role/domain/usecases/update_role.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final GetAllRoles getAllRoles;
  final GetRoleById getRoleById;
  final UpdateRoleById updateRoleById;
  final AddRole addRole;
  final DeleteRole deleteRole;

  RoleBloc(
    this.getAllRoles,
    this.updateRoleById,
    this.getRoleById,
    this.addRole,
    this.deleteRole,
  ) : super(RoleStateEmpty()) {
    on<GetAllRoleEvent>(_onGetAllRoles);
    on<GetRoleByIdEvent>(_onGetRoleById);
    on<UpdateRoleEvent>(_onUpdateRoleById);
    on<AddRoleEvent>(_onAddRole);
    on<DeleteRoleEvent>(_onDeleteRole);
  }

  void _onGetAllRoles(GetAllRoleEvent event, Emitter<RoleState> emit) async {
    emit(RoleStateLoading());
    Either<Failures, List<Role>> result = await getAllRoles.call();
    result.fold(
      (failure) =>
          emit(RoleStateError("Failed to load roles: ${failure.message}")),
      (roles) => emit(RoleStateLoaded(roles)),
    );
  }

  void _onGetRoleById(GetRoleByIdEvent event, Emitter<RoleState> emit) async {
    emit(RoleStateLoading());
    Either<Failures, Role> result = await getRoleById.call(event.roleId);
    result.fold(
      (failure) =>
          emit(RoleStateError("Failed to load role: ${failure.message}")),
      (role) => emit(RoleStateLoadedById(role)),
    );
  }

  void _onUpdateRoleById(UpdateRoleEvent event, Emitter<RoleState> emit) async {
    emit(RoleStateLoading());
    Either<Failures, Role> result =
        await updateRoleById.call(event.roleId, event.role);
    result.fold(
      (failure) =>
          emit(RoleOperationFailure("Role update failed: ${failure.message}")),
      (role) {
        emit(RoleOperationSuccess("Role updated successfully"));
        add(GetAllRoleEvent());
      },
    );
  }

  void _onAddRole(AddRoleEvent event, Emitter<RoleState> emit) async {
    emit(RoleStateLoading());
    Either<Failures, Role> result = await addRole.call(event.role);
    result.fold(
      (failure) => emit(
          RoleOperationFailure("Role creation failed: ${failure.message}")),
      (role) => emit(RoleOperationSuccess("Role created successfully")),
    );
  }

  void _onDeleteRole(DeleteRoleEvent event, Emitter<RoleState> emit) async {
    emit(RoleStateLoading());
    Either<Failures, String> result = await deleteRole.call(event.roleId);
    result.fold(
      (failure) => emit(
          RoleOperationFailure("Role deletion failed: ${failure.message}")),
      (message) {
        emit(RoleOperationSuccess("Role deleted successfully"));
        add(GetAllRoleEvent());
      },
    );
  }
}
