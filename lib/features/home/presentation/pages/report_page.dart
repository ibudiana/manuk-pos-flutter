import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionBloc>(
      create: (_) => sl<TransactionBloc>()..add(GetAllTransactionEvent()),
      child: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionOperationSuccess) {
            context.read<TransactionBloc>().add(GetAllTransactionEvent());
          } else if (state is TransactionStateError) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Error"),
                content: const Text("Failed to load transactions"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          }
        },
        child: const TransactionReportView(),
      ),
    );
  }
}

class TransactionReportView extends StatelessWidget {
  const TransactionReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Transaction Reports"),
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

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.transactions.length,
                itemBuilder: (_, i) {
                  final transaction = state.transactions[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      title: Text(transaction.invoiceNumber),
                      subtitle: Text('Date: ${transaction.createdAt}'),
                      trailing: Text(
                          'Rp. ${transaction.grandTotal.toStringAsFixed(0)}'),
                    ),
                  );
                },
              );
            }

            return const Center(child: Text("No transaction data"));
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}
