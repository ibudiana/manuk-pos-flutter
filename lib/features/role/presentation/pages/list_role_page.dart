import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/list_tile_menu.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/role/presentation/bloc/role_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ListRolePage extends StatelessWidget {
  const ListRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoleBloc>(
      create: (_) => sl<RoleBloc>()..add(GetAllRoleEvent()),
      child: BlocListener<RoleBloc, RoleState>(
        listener: (context, state) {
          if (state is RoleOperationSuccess) {
            context.read<RoleBloc>().add(GetAllRoleEvent());
          }
        },
        child: const ListRoleView(),
      ),
    );
  }
}

class ListRoleView extends StatelessWidget {
  const ListRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Roles"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<RoleBloc, RoleState>(
          builder: (context, state) {
            if (state is RoleStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RoleStateLoaded) {
              return ListView.separated(
                itemCount: state.roles.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final role = state.roles[index];
                  return CommonListTileWithMenu(
                    title: role.roleName,
                    onSelected: (value) async {
                      if (value == 'Edit') {
                        context.push('/setting/edit-role', extra: role);
                      } else if (value == 'Delete') {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: Text(
                                'Are you sure you want to delete the role ${role.roleName}?'),
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
                          context
                              .read<RoleBloc>()
                              .add(DeleteRoleEvent(role.id));
                        }
                      }
                    },
                  );
                },
              );
            } else if (state is RoleStateError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text("No role data"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () => context.go('/setting/add-role'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}
