import 'package:get_it/get_it.dart';
import 'package:manuk_pos/features/branch/domain/usecases/update_branch.dart';
import 'package:manuk_pos/features/user/data/datasources/remote_datasource.dart';
import 'package:manuk_pos/features/user/domain/repositories/user_repository.dart';
import 'package:manuk_pos/features/user/domain/usecases/add_user.dart';
import 'package:manuk_pos/features/user/domain/usecases/delete_user.dart';
import 'package:manuk_pos/features/user/domain/usecases/get_all_users.dart';
import 'package:manuk_pos/features/user/domain/usecases/get_user.dart';
import 'package:manuk_pos/features/user/domain/usecases/update_user.dart';
import 'package:manuk_pos/features/user/presentation/bloc/user_bloc.dart';

// Tambahan untuk branch
import 'package:manuk_pos/features/branch/data/datasources/branch_remote_datasource.dart';
import 'package:manuk_pos/features/branch/domain/repositories/branch_repository.dart';
import 'package:manuk_pos/features/branch/domain/usecases/get_all_branches.dart';
import 'package:manuk_pos/features/branch/presentation/bloc/branch_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // User
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<GetAllUsers>(() => GetAllUsers(sl()));
  sl.registerLazySingleton<GetUserById>(() => GetUserById(sl()));
  sl.registerLazySingleton<UpdateUserById>(() => UpdateUserById(sl()));
  sl.registerLazySingleton<AddUser>(() => AddUser(sl()));
  sl.registerLazySingleton<DeleteUser>(() => DeleteUser(sl()));
  sl.registerFactory(() => UserBloc(sl(), sl(), sl(), sl(), sl()));

  // Branch
  sl.registerLazySingleton<BranchRemoteDataSource>(
      () => BranchRemoteDataSourceImpl());
  sl.registerLazySingleton<BranchRepository>(
      () => BranchRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<GetAllBranches>(() => GetAllBranches(sl()));
  sl.registerLazySingleton<UpdateBranch>(() => UpdateBranch(sl()));

  sl.registerFactory(() => BranchBloc(sl(), sl()));
}
