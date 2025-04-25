import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/list_tile_menu.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ListTransactionPage extends StatelessWidget {
  const ListTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionBloc>(
      create: (_) => sl<TransactionBloc>()..add(GetAllTransactionEvent()),
      child: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionOperationSuccess) {
            // Optionally refetch transactions if needed
            context.read<TransactionBloc>().add(GetAllTransactionEvent());
          } else if (state is TransactionStateError) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Error"),
                content: const Text("List Transactions failed to load"),
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
        child: const ListTransactionView(),
      ),
    );
  }
}

class ListTransactionView extends StatelessWidget {
  const ListTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Transactions"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionStateLoaded) {
              if (state.transactions.isEmpty) {
                return const Center(
                    child: Text("No transaction data available"));
              }

              return ListView.separated(
                itemCount: state.transactions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final transaction = state.transactions[index];
                  return CommonListTileWithMenu(
                    title: transaction.invoiceNumber,
                    subtitle: 'Total: ${transaction.grandTotal}',
                    onSelected: (value) async {
                      switch (value) {
                        case 'Edit':
                          context.push('/home', extra: transaction);
                          break;
                        case 'Delete':
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: Text(
                                  'Are you sure you want to delete transaction "${transaction.invoiceNumber}"?'),
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
                                .read<TransactionBloc>()
                                .add(DeleteTransactionEvent(transaction.id));
                          }
                          break;
                      }
                    },
                  );
                },
              );
            }

            return const Center(child: Text("No transaction data"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () => context.go('/finance/add-transaction'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: -1),
    );
  }
}
