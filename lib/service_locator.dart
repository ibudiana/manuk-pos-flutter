import 'package:get_it/get_it.dart';
import 'package:manuk_pos/features/branch/domain/usecases/add_branch.dart';
import 'package:manuk_pos/features/branch/domain/usecases/delete_branch.dart';
import 'package:manuk_pos/features/branch/domain/usecases/get_branch.dart';
import 'package:manuk_pos/features/branch/domain/usecases/update_branch.dart';
import 'package:manuk_pos/features/category_product/data/datasources/category_product_remote_datasource.dart';
import 'package:manuk_pos/features/category_product/domain/repositories/category_product_repository.dart';
import 'package:manuk_pos/features/category_product/domain/usecases/add_category_product_.dart';
import 'package:manuk_pos/features/category_product/domain/usecases/delete_category_product_.dart';
import 'package:manuk_pos/features/category_product/domain/usecases/get_all_category_product_.dart';
import 'package:manuk_pos/features/category_product/domain/usecases/get_category_product_.dart';
import 'package:manuk_pos/features/category_product/domain/usecases/update_category_product_.dart';
import 'package:manuk_pos/features/category_product/presentation/bloc/category_product_bloc.dart';
import 'package:manuk_pos/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:manuk_pos/features/customer/domain/repositories/customer_repository.dart';
import 'package:manuk_pos/features/customer/domain/usecases/add_customer.dart';
import 'package:manuk_pos/features/customer/domain/usecases/delete_customer.dart';
import 'package:manuk_pos/features/customer/domain/usecases/get_all_customer.dart';
import 'package:manuk_pos/features/customer/domain/usecases/get_customer.dart';
import 'package:manuk_pos/features/customer/domain/usecases/update_customer.dart';
import 'package:manuk_pos/features/customer/presentation/bloc/customer_bloc.dart';
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
import 'package:manuk_pos/features/product/data/datasources/product_remote_datasource.dart';
import 'package:manuk_pos/features/product/domain/repositories/product_repository.dart';
import 'package:manuk_pos/features/product/domain/usecases/add_product.dart';
import 'package:manuk_pos/features/product/domain/usecases/delete_product.dart';
import 'package:manuk_pos/features/product/domain/usecases/get_all_product.dart';
import 'package:manuk_pos/features/product/domain/usecases/get_product.dart';
import 'package:manuk_pos/features/product/domain/usecases/update_product.dart';
import 'package:manuk_pos/features/product/presentation/bloc/product_bloc.dart';
import 'package:manuk_pos/features/role/data/datasources/role_remote_datasource.dart';
import 'package:manuk_pos/features/role/domain/repositories/role_repository.dart';
import 'package:manuk_pos/features/role/domain/usecases/add_role.dart';
import 'package:manuk_pos/features/role/domain/usecases/delete_role.dart';
import 'package:manuk_pos/features/role/domain/usecases/get_all_role.dart';
import 'package:manuk_pos/features/role/domain/usecases/get_role.dart';
import 'package:manuk_pos/features/role/domain/usecases/update_role.dart';
import 'package:manuk_pos/features/role/presentation/bloc/role_bloc.dart';
import 'package:manuk_pos/features/supplier/data/datasources/supplier_remote_datasource.dart';
import 'package:manuk_pos/features/supplier/domain/repositories/supplier_repository.dart';
import 'package:manuk_pos/features/supplier/domain/usecases/add_supplier.dart';
import 'package:manuk_pos/features/supplier/domain/usecases/delete_supplier.dart';
import 'package:manuk_pos/features/supplier/domain/usecases/get_all_supplier.dart';
import 'package:manuk_pos/features/supplier/domain/usecases/get_supplier.dart';
import 'package:manuk_pos/features/supplier/domain/usecases/update_supplier.dart';
import 'package:manuk_pos/features/supplier/presentation/bloc/supplier_bloc.dart';
import 'package:manuk_pos/features/tax/data/datasources/tax_remote_datasource.dart';
import 'package:manuk_pos/features/tax/domain/repositories/tax_repository.dart';
import 'package:manuk_pos/features/tax/domain/usecases/add_tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/delete_tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/get_all_tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/get_tax.dart';
import 'package:manuk_pos/features/tax/domain/usecases/update_tax.dart';
import 'package:manuk_pos/features/tax/presentation/bloc/tax_bloc.dart';
import 'package:manuk_pos/features/transaction/data/datasources/transaction_remote_datasource.dart';
import 'package:manuk_pos/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:manuk_pos/features/transaction/domain/usecases/add_transaction.dart';
import 'package:manuk_pos/features/transaction/domain/usecases/delete_transaction.dart';
import 'package:manuk_pos/features/transaction/domain/usecases/get_all_transaction.dart';
import 'package:manuk_pos/features/transaction/domain/usecases/get_transaction.dart';
import 'package:manuk_pos/features/transaction/domain/usecases/update_transaction.dart';
import 'package:manuk_pos/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:manuk_pos/features/user/data/datasources/user_remote_datasource.dart';
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

  // Supplier
  sl.registerLazySingleton<SupplierRemoteDataSource>(
      () => SupplierRemoteDataSourceImpl());

  sl.registerLazySingleton<SupplierRepository>(
      () => SupplierRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<GetAllSupplier>(() => GetAllSupplier(sl()));
  sl.registerLazySingleton<GetSupplierById>(() => GetSupplierById(sl()));
  sl.registerLazySingleton<AddSupplier>(() => AddSupplier(sl()));
  sl.registerLazySingleton<UpdateSupplierById>(() => UpdateSupplierById(sl()));
  sl.registerLazySingleton<DeleteSupplier>(() => DeleteSupplier(sl()));

  sl.registerFactory(() => SupplierBloc(sl(), sl(), sl(), sl(), sl()));

  // Customer
  sl.registerLazySingleton<CustomerRemoteDataSource>(
      () => CustomerRemoteDataSourceImpl());

  sl.registerLazySingleton<CustomerRepository>(
      () => CustomerRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<GetAllCustomer>(() => GetAllCustomer(sl()));
  sl.registerLazySingleton<GetCustomerById>(() => GetCustomerById(sl()));
  sl.registerLazySingleton<AddCustomer>(() => AddCustomer(sl()));
  sl.registerLazySingleton<UpdateCustomerById>(() => UpdateCustomerById(sl()));
  sl.registerLazySingleton<DeleteCustomer>(() => DeleteCustomer(sl()));

  sl.registerFactory(() => CustomerBloc(sl(), sl(), sl(), sl(), sl()));

  // Product
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl());

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<GetAllProduct>(() => GetAllProduct(sl()));
  sl.registerLazySingleton<GetProductById>(() => GetProductById(sl()));
  sl.registerLazySingleton<AddProduct>(() => AddProduct(sl()));
  sl.registerLazySingleton<UpdateProductById>(() => UpdateProductById(sl()));
  sl.registerLazySingleton<DeleteProduct>(() => DeleteProduct(sl()));

  sl.registerFactory(() => ProductBloc(sl(), sl(), sl(), sl(), sl()));

  // Category
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl());

  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<GetAllCategory>(() => GetAllCategory(sl()));
  sl.registerLazySingleton<GetCategoryById>(() => GetCategoryById(sl()));
  sl.registerLazySingleton<AddCategory>(() => AddCategory(sl()));
  sl.registerLazySingleton<UpdateCategoryById>(() => UpdateCategoryById(sl()));
  sl.registerLazySingleton<DeleteCategory>(() => DeleteCategory(sl()));

  sl.registerFactory(() => CategoryBloc(sl(), sl(), sl(), sl(), sl()));

  // Transaction
  sl.registerLazySingleton<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSourceImpl());

  sl.registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<GetAllTransaction>(() => GetAllTransaction(sl()));
  sl.registerLazySingleton<GetTransactionById>(() => GetTransactionById(sl()));
  sl.registerLazySingleton<AddTransaction>(() => AddTransaction(sl()));
  sl.registerLazySingleton<UpdateTransactionById>(
      () => UpdateTransactionById(sl()));
  sl.registerLazySingleton<DeleteTransaction>(() => DeleteTransaction(sl()));

  sl.registerFactory(() => TransactionBloc(sl(), sl(), sl(), sl(), sl()));
}
