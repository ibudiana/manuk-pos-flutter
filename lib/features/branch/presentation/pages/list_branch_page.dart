import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/list_tile_menu.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/branch/presentation/bloc/branch_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ListBranchPage extends StatelessWidget {
  const ListBranchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BranchBloc>(
      create: (_) => sl<BranchBloc>()..add(GetAllBranchEvent()),
      child: BlocListener<BranchBloc, BranchState>(
        listener: (context, state) {
          if (state is BranchOperationSuccess) {
            context.read<BranchBloc>().add(GetAllBranchEvent());
          }
        },
        child: const ListBranchView(),
      ),
    );
  }
}

class ListBranchView extends StatelessWidget {
  const ListBranchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Branch"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<BranchBloc, BranchState>(
          builder: (context, state) {
            if (state is BranchStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BranchStateLoaded) {
              return ListView.separated(
                itemCount: state.branches.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final branch = state.branches[index];
                  return CommonListTileWithMenu(
                    title: branch.name,
                    onSelected: (value) async {
                      if (value == 'Edit') {
                        context.push('/setting/edit-branch', extra: branch);
                      } else if (value == 'Delete') {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: Text(
                                'Are you sure you want to delete ${branch.name}?'),
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
                          // Belum ada delete di branch_bloc, nanti bisa ditambahkan
                          // context.read<BranchBloc>().add(DeleteBranchEvent(branch.id));
                        }
                      }
                    },
                  );
                },
              );
            } else if (state is BranchStateError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text("No branch data"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () => context.go('/setting/add-branch'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
