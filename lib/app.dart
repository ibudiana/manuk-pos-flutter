import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/routes/app_routes.dart';
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
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
