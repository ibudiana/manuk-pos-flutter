import 'package:go_router/go_router.dart';
import 'package:manuk_pos/features/branch/domain/entities/branch.dart';
import 'package:manuk_pos/features/branch/presentation/pages/branch_page.dart';
import 'package:manuk_pos/features/branch/presentation/pages/list_branch_page.dart';
import 'package:manuk_pos/features/discount/domain/entities/discount.dart';
import 'package:manuk_pos/features/discount/presentation/pages/discount_page.dart';
import 'package:manuk_pos/features/discount/presentation/pages/list_discount_page.dart';
import 'package:manuk_pos/features/home/home_feature.dart';
import 'package:manuk_pos/features/role/domain/entities/role.dart';
import 'package:manuk_pos/features/role/presentation/pages/list_role_page.dart';
import 'package:manuk_pos/features/role/presentation/pages/role_page.dart';
import 'package:manuk_pos/features/splash/splash_feature.dart';
import 'package:manuk_pos/features/onboard/onboard_feature.dart';
import 'package:manuk_pos/features/auth/auth_feature.dart';
import 'package:manuk_pos/features/user/domain/entities/user.dart';
import 'package:manuk_pos/features/user/presentation/pages/list_user_page.dart';
import 'package:manuk_pos/features/user/presentation/pages/user_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/setting/list-discount',
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
    GoRoute(
      path: '/setting',
      builder: (context, state) => const OnboardPage(),
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
