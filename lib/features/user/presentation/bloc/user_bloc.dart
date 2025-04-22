import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/error/failures.dart';
import 'package:manuk_pos/features/user/domain/entities/user.dart';
import 'package:manuk_pos/features/user/domain/usecases/add_user.dart';
import 'package:manuk_pos/features/user/domain/usecases/delete_user.dart';
import 'package:manuk_pos/features/user/domain/usecases/get_all_users.dart';
import 'package:manuk_pos/features/user/domain/usecases/get_user.dart';
import 'package:manuk_pos/features/user/domain/usecases/update_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUsers getAllUsers;
  final GetUserById getUserById;
  final UpdateUserById updateUserById;
  final AddUser addUser;
  final DeleteUser deleteUser;

  UserBloc(this.getAllUsers, this.getUserById, this.updateUserById,
      this.addUser, this.deleteUser)
      : super(UserStateEmpty()) {
    on<GetAllUsersEvent>(_onGetAllUsers);
    on<GetUserByIdEvent>(_onGetUserById);
    on<UpdateUserEvent>(_onUpdateUserById);
    on<AddUserEvent>(_onAddUser);
    on<DeleteUserEvent>(_onDeleteUser);
  }

  void _onGetAllUsers(GetAllUsersEvent event, Emitter<UserState> emit) async {
    emit(UserStateLoading());
    Either<Failures, List<User>> result = await getAllUsers.call();
    result.fold(
      (failure) =>
          emit(UserStateError("Failed to load users: ${failure.message}")),
      (users) => emit(UserStateLoaded(users)),
    );
  }

  void _onGetUserById(GetUserByIdEvent event, Emitter<UserState> emit) async {
    emit(UserStateLoading());
    Either<Failures, User> result = await getUserById.call(event.userId);
    result.fold(
      (failure) =>
          emit(UserStateError("Failed to load user: ${failure.message}")),
      (user) => emit(UserStateLoadedById(user)),
    );
  }

  void _onUpdateUserById(UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(UserStateLoading());
    Either<Failures, User> result =
        await updateUserById.call(event.userId, event.user);
    result.fold(
      (failure) =>
          emit(UserOperationFailure("User updated Failed: ${failure.message}")),
      (user) {
        emit(UserOperationSuccess("User updated successfully"));
        add(GetAllUsersEvent());
      },
    );
  }

  void _onAddUser(AddUserEvent event, Emitter<UserState> emit) async {
    emit(UserStateLoading());
    Either<Failures, User> result = await addUser.call(event.user);
    result.fold(
      (failure) =>
          emit(UserOperationFailure("User create failed: ${failure.message}")),
      (user) => emit(UserOperationSuccess("User created successfully")),
    );
  }

  void _onDeleteUser(DeleteUserEvent event, Emitter<UserState> emit) async {
    emit(UserStateLoading());
    Either<Failures, String> result = await deleteUser.call(event.userId);
    result.fold(
      (failure) =>
          emit(UserOperationFailure("User deleted Failed: ${failure.message}")),
      (user) {
        emit(UserOperationSuccess("User delete successfully"));
        add(GetAllUsersEvent());
      },
    );
  }
}
