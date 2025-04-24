import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/list_tile_menu.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/tax/presentation/bloc/tax_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ListTaxPage extends StatelessWidget {
  const ListTaxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaxBloc>(
      create: (_) => sl<TaxBloc>()..add(GetAllTaxEvent()),
      child: BlocListener<TaxBloc, TaxState>(
        listener: (context, state) {
          if (state is TaxOperationSuccess) {
            context.read<TaxBloc>().add(GetAllTaxEvent());
          }
          if (state is TaxStateError) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Error"),
                content: Text("List Tax failed to load"),
                actions: [
                  TextButton(
                    onPressed: () => context.go('/'),
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          }
        },
        child: const ListTaxView(),
      ),
    );
  }
}

class ListTaxView extends StatelessWidget {
  const ListTaxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Taxes"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<TaxBloc, TaxState>(
          builder: (context, state) {
            if (state is TaxStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaxStateLoaded) {
              return ListView.separated(
                itemCount: state.taxes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final tax = state.taxes[index];
                  return CommonListTileWithMenu(
                    title: tax.name,
                    onSelected: (value) async {
                      if (value == 'Edit') {
                        context.push('/finance/edit-tax', extra: tax);
                      } else if (value == 'Delete') {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: Text(
                                'Are you sure you want to delete the tax ${tax.name}?'),
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
                          context.read<TaxBloc>().add(DeleteTaxEvent(tax.id));
                        }
                      }
                    },
                  );
                },
              );
            }

            return const Center(child: Text("No tax data"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () => context.go('/finance/add-tax'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: -1),
    );
  }
}
