part of 'role_bloc.dart';

abstract class RoleEvent extends Equatable {
  const RoleEvent();

  @override
  List<Object> get props => [];
}

class GetAllRoleEvent extends RoleEvent {
  const GetAllRoleEvent();

  @override
  List<Object> get props => [];
}

class GetRoleByIdEvent extends RoleEvent {
  final int roleId;

  const GetRoleByIdEvent(this.roleId);

  @override
  List<Object> get props => [roleId];
}

class AddRoleEvent extends RoleEvent {
  final Role role;

  const AddRoleEvent(this.role);

  @override
  List<Object> get props => [role];
}

class UpdateRoleEvent extends RoleEvent {
  final int roleId;
  final Role role;

  const UpdateRoleEvent(this.roleId, this.role);

  @override
  List<Object> get props => [roleId, role];
}

class DeleteRoleEvent extends RoleEvent {
  final int roleId;

  const DeleteRoleEvent(this.roleId);

  @override
  List<Object> get props => [roleId];
}
