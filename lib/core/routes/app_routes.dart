import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/features/branch/domain/entities/branch.dart';
import 'package:manuk_pos/features/branch/presentation/pages/branch_page.dart';
import 'package:manuk_pos/features/branch/presentation/pages/list_branch_page.dart';
import 'package:manuk_pos/features/category_product/domain/entities/category_product_.dart';
import 'package:manuk_pos/features/category_product/presentation/pages/category_product_page.dart';
import 'package:manuk_pos/features/category_product/presentation/pages/list_category_product_page.dart';
import 'package:manuk_pos/features/customer/domain/entities/customer.dart';
import 'package:manuk_pos/features/customer/presentation/pages/customer_page.dart';
import 'package:manuk_pos/features/customer/presentation/pages/list_customer_page.dart';
import 'package:manuk_pos/features/discount/domain/entities/discount.dart';
import 'package:manuk_pos/features/discount/presentation/pages/discount_page.dart';
import 'package:manuk_pos/features/discount/presentation/pages/list_discount_page.dart';
import 'package:manuk_pos/features/fee/domain/entities/fee.dart';
import 'package:manuk_pos/features/fee/presentation/pages/fee_page.dart';
import 'package:manuk_pos/features/fee/presentation/pages/list_fee_page.dart';
import 'package:manuk_pos/features/home/home_feature.dart';
import 'package:manuk_pos/features/loan/domain/entities/loan.dart';
import 'package:manuk_pos/features/loan/presentation/pages/list_loan_page.dart';
import 'package:manuk_pos/features/loan/presentation/pages/loan_page.dart';
import 'package:manuk_pos/features/product/domain/entities/product.dart';
import 'package:manuk_pos/features/product/presentation/pages/list_product_page.dart';
import 'package:manuk_pos/features/product/presentation/pages/product_page.dart';
import 'package:manuk_pos/features/role/domain/entities/role.dart';
import 'package:manuk_pos/features/role/presentation/pages/list_role_page.dart';
import 'package:manuk_pos/features/role/presentation/pages/role_page.dart';
import 'package:manuk_pos/features/splash/splash_feature.dart';
import 'package:manuk_pos/features/onboard/onboard_feature.dart';
import 'package:manuk_pos/features/auth/auth_feature.dart';
import 'package:manuk_pos/features/supplier/domain/entities/supplier.dart';
import 'package:manuk_pos/features/supplier/presentation/pages/list_supplier_page.dart';
import 'package:manuk_pos/features/supplier/presentation/pages/supplier_page.dart';
import 'package:manuk_pos/features/tax/domain/entities/tax.dart';
import 'package:manuk_pos/features/tax/presentation/pages/list_tax_page.dart';
import 'package:manuk_pos/features/tax/presentation/pages/tax_page.dart';
import 'package:manuk_pos/features/user/domain/entities/user.dart';
import 'package:manuk_pos/features/user/presentation/pages/list_user_page.dart';
import 'package:manuk_pos/features/user/presentation/pages/user_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/inventory/product/list-product',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/onboard',
      builder: (context, state) => const OnboardPage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const OnboardPage(),
      routes: [
        GoRoute(
          path: 'signup',
          builder: (context, state) => const SignupPage(),
        ),
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: 'forgot-password',
          builder: (context, state) => const ForgotPasswordPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const OnboardPage(),
      routes: [
        GoRoute(
          path: 'dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: 'product',
          builder: (context, state) => const ProductPage(),
        ),
        GoRoute(
          path: 'order',
          builder: (context, state) => const OrderPage(),
        ),
        GoRoute(
          path: 'report',
          builder: (context, state) => const ReportPage(),
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
    // Product Routes
    GoRoute(
      path: '/inventory',
      builder: (context, state) => const SizedBox.shrink(),
      routes: [
        // Product Routes
        GoRoute(
          path: 'product/list-product',
          builder: (context, state) => const ListProductPage(),
        ),
        GoRoute(
          path: 'product/add-product',
          builder: (context, state) => const AddProductPage(),
        ),
        GoRoute(
          path: 'product/edit-product',
          builder: (context, state) {
            final product = state.extra as Product;
            return AddProductPage(product: product);
          },
        ),
        // Category Product Routes (Child Routes under Product)
        GoRoute(
          path: 'product/category/list-category',
          builder: (context, state) => const ListCategoryPage(),
        ),
        GoRoute(
          path: 'product/category/add-category',
          builder: (context, state) => const AddCategoryPage(),
        ),
        GoRoute(
          path: 'product/category/edit-category',
          builder: (context, state) {
            final category = state.extra as Category;
            return AddCategoryPage(category: category);
          },
        ),
      ],
    ),
    // Database Routes
    GoRoute(
      path: '/databases',
      builder: (context, state) => const SizedBox.shrink(),
      routes: [
        // Customer Routes
        GoRoute(
          path: '/customer/list-customer',
          builder: (context, state) => const ListCustomerPage(),
        ),
        GoRoute(
          path: '/customer/add-customer',
          builder: (context, state) => const AddCustomerPage(),
        ),
        GoRoute(
          path: '/customer/edit-customer',
          builder: (context, state) {
            final customer = state.extra as Customer;
            return AddCustomerPage(customer: customer);
          },
        ),
        // Supplier Routes
        GoRoute(
          path: '/supplier/list-supplier',
          builder: (context, state) => const ListSupplierPage(),
        ),
        GoRoute(
          path: '/supplier/add-supplier',
          builder: (context, state) => const AddSupplierPage(),
        ),
        GoRoute(
          path: '/supplier/edit-supplier',
          builder: (context, state) {
            final supplier = state.extra as Supplier;
            return AddSupplierPage(supplier: supplier);
          },
        ),
      ],
    ),
    // Finance Routes
    GoRoute(
      path: '/finance',
      builder: (context, state) => const SizedBox.shrink(),
      routes: [
        // Tax Routes
        GoRoute(
          path: 'list-tax',
          builder: (context, state) => const ListTaxPage(),
        ),
        GoRoute(
          path: 'add-tax',
          builder: (context, state) => const AddTaxPage(),
        ),
        GoRoute(
          path: 'edit-tax',
          builder: (context, state) {
            final tax = state.extra as Tax;
            return AddTaxPage(tax: tax);
          },
        ),

        // Fee Routes
        GoRoute(
          path: 'list-fee',
          builder: (context, state) => const ListFeePage(),
        ),
        GoRoute(
          path: 'add-fee',
          builder: (context, state) => const AddFeePage(),
        ),
        GoRoute(
          path: 'edit-fee',
          builder: (context, state) {
            final fee = state.extra as Fee;
            return AddFeePage(fee: fee);
          },
        ),

        // Loan Routes
        GoRoute(
          path: 'list-loan',
          builder: (context, state) => const ListLoanPage(),
        ),
        GoRoute(
          path: 'add-loan',
          builder: (context, state) => const AddLoanPage(),
        ),
        GoRoute(
          path: 'edit-loan',
          builder: (context, state) {
            final loan = state.extra as Loan;
            return AddLoanPage(loan: loan);
          },
        ),
      ],
    ),

    // Setting Routes
    GoRoute(
      path: '/setting',
      builder: (context, state) => const SizedBox.shrink(),
      routes: [
        // User Routes
        GoRoute(
          path: 'list-user',
          builder: (context, state) => const ListUserPage(),
        ),
        GoRoute(
          path: 'add-user',
          builder: (context, state) => const AddUserPage(),
        ),
        GoRoute(
          path: 'edit-user',
          builder: (context, state) {
            final user = state.extra as User;
            return AddUserPage(user: user);
          },
        ),

        // Branch Routes
        GoRoute(
          path: 'branches',
          builder: (context, state) => const ListBranchPage(),
        ),
        GoRoute(
          path: 'add-branch',
          builder: (context, state) => const AddBranchPage(),
        ),
        GoRoute(
          path: 'edit-branch',
          builder: (context, state) {
            final branch = state.extra as Branch;
            return AddBranchPage(branch: branch);
          },
        ),

        // Discount Routes
        GoRoute(
          path: 'list-discount',
          builder: (context, state) => const ListDiscountPage(),
        ),
        GoRoute(
          path: 'add-discount',
          builder: (context, state) => const AddDiscountPage(),
        ),
        GoRoute(
          path: 'edit-discount',
          builder: (context, state) {
            final discount = state.extra as Discount;
            return AddDiscountPage(discount: discount);
          },
        ),

        // Role Routes
        GoRoute(
          path: 'list-role',
          builder: (context, state) => const ListRolePage(),
        ),
        GoRoute(
          path: 'add-role',
          builder: (context, state) => const AddRolePage(),
        ),
        GoRoute(
          path: 'edit-role',
          builder: (context, state) {
            final role = state.extra as Role;
            return AddRolePage(role: role);
          },
        ),
      ],
    )
  ],
);
