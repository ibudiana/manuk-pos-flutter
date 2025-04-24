import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/routes/app_routes.dart';
import 'package:manuk_pos/features/category_product/presentation/bloc/category_product_bloc.dart';
import 'package:manuk_pos/features/customer/presentation/bloc/customer_bloc.dart';
import 'package:manuk_pos/features/discount/presentation/bloc/discount_bloc.dart';
import 'package:manuk_pos/features/fee/presentation/bloc/fee_bloc.dart';
import 'package:manuk_pos/features/loan/presentation/bloc/loan_bloc.dart';
import 'package:manuk_pos/features/product/presentation/bloc/product_bloc.dart';
import 'package:manuk_pos/features/role/presentation/bloc/role_bloc.dart';
import 'package:manuk_pos/features/supplier/presentation/bloc/supplier_bloc.dart';
import 'package:manuk_pos/features/tax/presentation/bloc/tax_bloc.dart';
import 'package:manuk_pos/features/user/presentation/bloc/user_bloc.dart';
import 'package:manuk_pos/features/branch/presentation/bloc/branch_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ManukPosApp extends StatelessWidget {
  const ManukPosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<UserBloc>()),
        BlocProvider(create: (_) => sl<BranchBloc>()),
        BlocProvider(create: (_) => sl<DiscountBloc>()),
        BlocProvider(create: (_) => sl<RoleBloc>()),
        BlocProvider(create: (_) => sl<TaxBloc>()),
        BlocProvider(create: (_) => sl<LoanBloc>()),
        BlocProvider(create: (_) => sl<FeeBloc>()),
        BlocProvider(create: (_) => sl<SupplierBloc>()),
        BlocProvider(create: (_) => sl<CustomerBloc>()),
        BlocProvider(create: (_) => sl<ProductBloc>()),
        BlocProvider(create: (_) => sl<CategoryBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
