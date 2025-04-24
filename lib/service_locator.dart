import 'package:get_it/get_it.dart';
import 'package:manuk_pos/features/branch/domain/usecases/add_branch.dart';
import 'package:manuk_pos/features/branch/domain/usecases/delete_branch.dart';
import 'package:manuk_pos/features/branch/domain/usecases/get_branch.dart';
import 'package:manuk_pos/features/branch/domain/usecases/update_branch.dart';
import 'package:manuk_pos/features/discount/data/datasources/discount_remote_datasource.dart';
import 'package:manuk_pos/features/discount/domain/repositories/discount_repository.dart';
import 'package:manuk_pos/features/discount/domain/usecases/add_discount.dart';
import 'package:manuk_pos/features/discount/domain/usecases/delete_discount.dart';
import 'package:manuk_pos/features/discount/domain/usecases/get_all_discount.dart';
import 'package:manuk_pos/features/discount/domain/usecases/get_discount.dart';
import 'package:manuk_pos/features/discount/domain/usecases/update_discount.dart';
import 'package:manuk_pos/features/discount/presentation/bloc/discount_bloc.dart';
import 'package:manuk_pos/features/fee/data/datasources/fee_remote_datasource.dart';
import 'package:manuk_pos/features/fee/domain/repositories/fee_repository.dart';
import 'package:manuk_pos/features/fee/domain/usecases/add_fee.dart';
import 'package:manuk_pos/features/fee/domain/usecases/delete_fee.dart';
import 'package:manuk_pos/features/fee/domain/usecases/get_all_fee.dart';
import 'package:manuk_pos/features/fee/domain/usecases/get_fee.dart';
import 'package:manuk_pos/features/fee/domain/usecases/update_fee.dart';
import 'package:manuk_pos/features/fee/presentation/bloc/fee_bloc.dart';
import 'package:manuk_pos/features/loan/data/datasources/loan_remote_datasource.dart';
import 'package:manuk_pos/features/loan/domain/repositories/loan_repository.dart';
import 'package:manuk_pos/features/loan/domain/usecases/add_loan.dart';
import 'package:manuk_pos/features/loan/domain/usecases/delete_loan.dart';
import 'package:manuk_pos/features/loan/domain/usecases/get_all_loan.dart';
import 'package:manuk_pos/features/loan/domain/usecases/get_loan.dart';
import 'package:manuk_pos/features/loan/domain/usecases/update_loan.dart';
import 'package:manuk_pos/features/loan/presentation/bloc/loan_bloc.dart';
import 'package:manuk_pos/features/role/data/datasources/role_remote_datasource.dart';
import 'package:manuk_pos/features/role/domain/repositories/role_repository.dart';
import 'package:manuk_pos/features/role/domain/usecases/add_role.dart';
import 'package:manuk_pos/features/role/domain/usecases/delete_role.dart';
import 'package:manuk_pos/features/role/domain/usecases/get_all_role.dart';
import 'package:manuk_pos/features/role/domain/usecases/get_role.dart';
import 'package:manuk_pos/features/role/domain/usecases/update_role.dart';
import 'package:manuk_pos/features/role/presentation/bloc/role_bloc.dart';
import 'package:manuk_pos/features/tax/data/datasources/tax_remote_datasource.dart';
import 'package:manuk_pos/features/tax/domain/repositories/tax_repository.dart';
import 'package:manuk_pos/features/tax/domain/usecases/add_tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/delete_tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/get_all_tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/get_tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/update_tax.dart';
import 'package:manuk_pos/features/tax/presentation/bloc/tax_bloc.dart';
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
import 'package:manuk_pos/features/branch/domain/usecases/get_all_branch.dart';
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
  sl.registerLazySingleton<UpdateBranchById>(() => UpdateBranchById(sl()));
  sl.registerLazySingleton<AddBranch>(() => AddBranch(sl()));
  sl.registerLazySingleton<DeleteBranch>(() => DeleteBranch(sl()));
  sl.registerLazySingleton<GetBranchById>(() => GetBranchById(sl()));

  sl.registerFactory(() => BranchBloc(sl(), sl(), sl(), sl(), sl()));

  // Discount
  sl.registerLazySingleton<DiscountRemoteDataSource>(
      () => DiscountRemoteDataSourceImpl());
  sl.registerLazySingleton<DiscountRepository>(
      () => DiscountRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<GetAllDiscounts>(() => GetAllDiscounts(sl()));
  sl.registerLazySingleton<UpdateDiscountById>(() => UpdateDiscountById(sl()));
  sl.registerLazySingleton<AddDiscount>(() => AddDiscount(sl()));
  sl.registerLazySingleton<DeleteDiscount>(() => DeleteDiscount(sl()));
  sl.registerLazySingleton<GetDiscountById>(() => GetDiscountById(sl()));
  sl.registerFactory(() => DiscountBloc(sl(), sl(), sl(), sl(), sl()));

  // Role
  sl.registerLazySingleton<RoleRemoteDataSource>(
      () => RoleRemoteDataSourceImpl());
  sl.registerLazySingleton<RoleRepository>(
      () => RoleRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<GetAllRoles>(() => GetAllRoles(sl()));
  sl.registerLazySingleton<UpdateRoleById>(() => UpdateRoleById(sl()));
  sl.registerLazySingleton<AddRole>(() => AddRole(sl()));
  sl.registerLazySingleton<DeleteRole>(() => DeleteRole(sl()));
  sl.registerLazySingleton<GetRoleById>(() => GetRoleById(sl()));
  sl.registerFactory(() => RoleBloc(sl(), sl(), sl(), sl(), sl()));

  // Tax
  sl.registerLazySingleton<TaxRemoteDataSource>(
      () => TaxRemoteDataSourceImpl());

  sl.registerLazySingleton<TaxRepository>(
      () => TaxRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<GetAllTax>(() => GetAllTax(sl()));
  sl.registerLazySingleton<GetTaxById>(() => GetTaxById(sl()));
  sl.registerLazySingleton<AddTax>(() => AddTax(sl()));
  sl.registerLazySingleton<UpdateTaxById>(() => UpdateTaxById(sl()));
  sl.registerLazySingleton<DeleteTax>(() => DeleteTax(sl()));

  sl.registerFactory(() => TaxBloc(sl(), sl(), sl(), sl(), sl()));

  // Loan
  sl.registerLazySingleton<LoanRemoteDataSource>(
      () => LoanRemoteDataSourceImpl());

  sl.registerLazySingleton<LoanRepository>(
      () => LoanRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<GetAllLoan>(() => GetAllLoan(sl()));
  sl.registerLazySingleton<GetLoanById>(() => GetLoanById(sl()));
  sl.registerLazySingleton<AddLoan>(() => AddLoan(sl()));
  sl.registerLazySingleton<UpdateLoanById>(() => UpdateLoanById(sl()));
  sl.registerLazySingleton<DeleteLoan>(() => DeleteLoan(sl()));

  sl.registerFactory(() => LoanBloc(sl(), sl(), sl(), sl(), sl()));

  // Fee
  sl.registerLazySingleton<FeeRemoteDataSource>(
      () => FeeRemoteDataSourceImpl());

  sl.registerLazySingleton<FeeRepository>(
      () => FeeRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<GetAllFee>(() => GetAllFee(sl()));
  sl.registerLazySingleton<GetFeeById>(() => GetFeeById(sl()));
  sl.registerLazySingleton<AddFee>(() => AddFee(sl()));
  sl.registerLazySingleton<UpdateFeeById>(() => UpdateFeeById(sl()));
  sl.registerLazySingleton<DeleteFee>(() => DeleteFee(sl()));

  sl.registerFactory(() => FeeBloc(sl(), sl(), sl(), sl(), sl()));
}
