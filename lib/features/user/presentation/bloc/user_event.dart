part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetAllUsersEvent extends UserEvent {
  const GetAllUsersEvent();

  @override
  List<Object> get props => [];
}

class GetUserByIdEvent extends UserEvent {
  final int userId;

  const GetUserByIdEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddUserEvent extends UserEvent {
  final User user;
  const AddUserEvent(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateUserEvent extends UserEvent {
  final User user;
  final int userId;

  const UpdateUserEvent(this.userId, this.user);
}

class DeleteUserEvent extends UserEvent {
  final int userId;

  const DeleteUserEvent(this.userId);
}
