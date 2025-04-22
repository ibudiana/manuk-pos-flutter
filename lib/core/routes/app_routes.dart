import 'package:go_router/go_router.dart';
import 'package:manuk_pos/features/branch/domain/entities/branch.dart';
import 'package:manuk_pos/features/branch/presentation/pages/branch_page.dart';
import 'package:manuk_pos/features/branch/presentation/pages/list_branch_page.dart';
import 'package:manuk_pos/features/home/home_feature.dart';
import 'package:manuk_pos/features/splash/splash_feature.dart';
import 'package:manuk_pos/features/onboard/onboard_feature.dart';
import 'package:manuk_pos/features/auth/auth_feature.dart';
import 'package:manuk_pos/features/user/domain/entities/user.dart';
import 'package:manuk_pos/features/user/presentation/pages/list_user_page.dart';
import 'package:manuk_pos/features/user/presentation/pages/user_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
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
        GoRoute(
          path: 'list-user',
          builder: (context, state) => const ListUserPage(),
        ),
        // ADD USER
        GoRoute(
          path: 'add-user',
          builder: (context, state) => const AddUserPage(),
        ),
        // EDIT USER
        GoRoute(
          path: 'edit-user',
          builder: (context, state) {
            final user = state.extra as User;
            return AddUserPage(user: user);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/setting',
      builder: (context, state) => const OnboardPage(),
      routes: [
        GoRoute(
          path: 'branches',
          builder: (context, state) => const ListBranchPage(),
        ),
        // ADD USER
        GoRoute(
          path: 'add-branch',
          builder: (context, state) => const AddBranchPage(),
        ),
        // EDIT USER
        GoRoute(
          path: 'edit-branch',
          builder: (context, state) {
            final branch = state.extra as Branch;
            return AddBranchPage(branch: branch);
          },
        ),
      ],
    ),
  ],
);
