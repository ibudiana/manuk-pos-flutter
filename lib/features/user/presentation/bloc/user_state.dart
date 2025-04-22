part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserStateEmpty extends UserState {}

class UserStateLoading extends UserState {}

class UserStateError extends UserState {
  final String message;

  const UserStateError(this.message);

  @override
  List<Object> get props => [message];
}

class UserStateLoaded extends UserState {
  final List<User> users;

  const UserStateLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserStateLoadedById extends UserState {
  final User user;

  const UserStateLoadedById(this.user);

  @override
  List<Object> get props => [user];
}

class UserDeleteSuccess extends UserState {
  final String message;

  const UserDeleteSuccess(this.message);
}

class UserOperationSuccess extends UserState {
  final String message;

  const UserOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class UserOperationFailure extends UserState {
  final String message;

  const UserOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
