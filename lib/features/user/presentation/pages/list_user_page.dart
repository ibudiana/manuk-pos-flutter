import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/list_tile_menu.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/user/domain/usecases/get_user.dart';
import 'package:manuk_pos/features/user/presentation/bloc/user_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ListUserPage extends StatelessWidget {
  const ListUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (_) =>
          sl<UserBloc>()..add(GetAllUsersEvent()), // <- langsung load user
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserOperationSuccess) {
            // Trigger reload data when user operation is successful
            context.read<UserBloc>().add(GetAllUsersEvent());
          }
        },
        child: const ListUserView(), // Pisahkan UI ke widget sendiri
      ),
    );
  }
}

class ListUserView extends StatelessWidget {
  const ListUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserStateLoaded) {
              return ListView.separated(
                itemCount: state.users.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return CommonListTileWithMenu(
                    title: user.name,
                    onSelected: (value) async {
                      if (value == 'Edit') {
                        final userId = user.id;
                        final result = await sl<GetUserById>().call(userId);

                        result.fold(
                          (failure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Failed to load user: ${failure.toString()}')),
                            );
                          },
                          (userData) {
                            context.push('/setting/edit-user', extra: userData);
                          },
                        );
                      } else if (value == 'Delete') {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: Text(
                                'Are you sure you want to delete ${user.name}?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          final result = await context
                              .read<UserBloc>()
                              .deleteUser(user.id);

                          result.fold(
                            (failure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Failed to delete user: ${failure.toString()}')),
                              );
                            },
                            (message) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)),
                              );
                              context
                                  .read<UserBloc>()
                                  .add(GetAllUsersEvent()); // Refresh list
                            },
                          );
                        }
                      }
                    },
                  );
                },
              );
            } else if (state is UserStateError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text("No data available"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () => context.go('/setting/add-user'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
