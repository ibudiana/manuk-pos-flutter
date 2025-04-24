import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/list_tile_menu.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/supplier/presentation/bloc/supplier_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ListSupplierPage extends StatelessWidget {
  const ListSupplierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SupplierBloc>(
      create: (_) => sl<SupplierBloc>()..add(GetAllSupplierEvent()),
      child: BlocListener<SupplierBloc, SupplierState>(
        listener: (context, state) {
          if (state is SupplierOperationSuccess) {
            // Optionally refetch suppliers if needed
            context.read<SupplierBloc>().add(GetAllSupplierEvent());
          } else if (state is SupplierStateError) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Error"),
                content: const Text("List Suppliers failed to load"),
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
        child: const ListSupplierView(),
      ),
    );
  }
}

class ListSupplierView extends StatelessWidget {
  const ListSupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Suppliers"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<SupplierBloc, SupplierState>(
          builder: (context, state) {
            if (state is SupplierStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SupplierStateLoaded) {
              if (state.suppliers.isEmpty) {
                return const Center(child: Text("No supplier data available"));
              }

              return ListView.separated(
                itemCount: state.suppliers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final supplier = state.suppliers[index];
                  return CommonListTileWithMenu(
                    title: supplier.name,
                    subtitle: supplier.contactPerson,
                    onSelected: (value) async {
                      switch (value) {
                        case 'Edit':
                          context.push('/databases/supplier/edit-supplier',
                              extra: supplier);
                          break;
                        case 'Delete':
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: Text(
                                  'Are you sure you want to delete the supplier "${supplier.name}"?'),
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
                            context
                                .read<SupplierBloc>()
                                .add(DeleteSupplierEvent(supplier.id));
                          }
                          break;
                      }
                    },
                  );
                },
              );
            }

            return const Center(child: Text("No supplier data"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () => context.go('/databases/supplier/add-supplier'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: -1),
    );
  }
}
