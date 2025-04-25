import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
        child: const DashboardView(),
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
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

              // Example summary data, you can adapt this according to actual data
              final totalSales = state.transactions.fold(
                0.0,
                (previousValue, transaction) =>
                    previousValue + transaction.grandTotal,
              );

              final totalTransactions = state.transactions.length;

              return ListView(
                children: [
                  _buildTransactionSummaryCard(
                    context,
                    title: 'Total Sales Today',
                    amount: totalSales,
                    transactionCount: totalTransactions,
                  ),
                  _buildTransactionSummaryCard(
                    context,
                    title: 'Total Transactions',
                    amount:
                        totalSales, // Replace with actual total transaction amount
                    transactionCount: totalTransactions,
                  ),
                  // Add more cards as needed
                ],
              );
            }

            return const Center(child: Text("No transaction data"));
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildTransactionSummaryCard(
    BuildContext context, {
    required String title,
    required double amount,
    required int transactionCount,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTheme.headingText,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount: Rp ${amount.toStringAsFixed(0)}',
                  style: AppTheme.bodyText,
                ),
                Text(
                  '$transactionCount Transactions',
                  style: AppTheme.bodyText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
