import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/list_tile_menu.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/fee/presentation/bloc/fee_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ListFeePage extends StatelessWidget {
  const ListFeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeeBloc>(
      create: (_) => sl<FeeBloc>()..add(GetAllFeeEvent()),
      child: BlocListener<FeeBloc, FeeState>(
        listener: (context, state) {
          if (state is FeeOperationSuccess) {
            // Optionally refetch fees if needed
            context.read<FeeBloc>().add(GetAllFeeEvent());
          } else if (state is FeeStateError) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Error"),
                content: const Text("List Fees failed to load"),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          }
        },
        child: const ListFeeView(),
      ),
    );
  }
}

class ListFeeView extends StatelessWidget {
  const ListFeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Fees"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<FeeBloc, FeeState>(
          builder: (context, state) {
            if (state is FeeStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FeeStateLoaded) {
              if (state.fees.isEmpty) {
                return const Center(child: Text("No fee data available"));
              }

              return ListView.separated(
                itemCount: state.fees.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final fee = state.fees[index];
                  return CommonListTileWithMenu(
                    title: fee.name,
                    onSelected: (value) async {
                      switch (value) {
                        case 'Edit':
                          context.push('/finance/edit-fee', extra: fee);
                          break;
                        case 'Delete':
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: Text(
                                  'Are you sure you want to delete the fee "${fee.id}"?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
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
                            context.read<FeeBloc>().add(DeleteFeeEvent(fee.id));
                          }
                          break;
                      }
                    },
                  );
                },
              );
            }

            return const Center(child: Text("No fee data"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () => context.go('/finance/add-fee'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: -1),
    );
  }
}
