part of 'role_bloc.dart';

abstract class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object> get props => [];
}

class RoleStateEmpty extends RoleState {}

class RoleStateLoading extends RoleState {}

class RoleStateError extends RoleState {
  final String message;

  const RoleStateError(this.message);

  @override
  List<Object> get props => [message];
}

class RoleStateLoaded extends RoleState {
  final List<Role> roles;

  const RoleStateLoaded(this.roles);

  @override
  List<Object> get props => [roles];
}

class RoleStateLoadedById extends RoleState {
  final Role role;

  const RoleStateLoadedById(this.role);

  @override
  List<Object> get props => [role];
}

class RoleDeleteSuccess extends RoleState {
  final String message;

  const RoleDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RoleOperationSuccess extends RoleState {
  final String message;

  const RoleOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RoleOperationFailure extends RoleState {
  final String message;

  const RoleOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
