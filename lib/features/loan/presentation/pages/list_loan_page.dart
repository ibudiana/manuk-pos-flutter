import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/list_tile_menu.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/loan/presentation/bloc/loan_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ListLoanPage extends StatelessWidget {
  const ListLoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoanBloc>(
      create: (_) => sl<LoanBloc>()..add(GetAllLoanEvent()),
      child: BlocListener<LoanBloc, LoanState>(
        listener: (context, state) {
          if (state is LoanOperationSuccess) {
            // Optionally refetch loans if needed
            context.read<LoanBloc>().add(GetAllLoanEvent());
          } else if (state is LoanStateError) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Error"),
                content: const Text("List Loans failed to load"),
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
        child: const ListLoanView(),
      ),
    );
  }
}

class ListLoanView extends StatelessWidget {
  const ListLoanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Loans"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<LoanBloc, LoanState>(
          builder: (context, state) {
            if (state is LoanStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoanStateLoaded) {
              if (state.loans.isEmpty) {
                return const Center(child: Text("No loan data available"));
              }

              return ListView.separated(
                itemCount: state.loans.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final loan = state.loans[index];
                  return CommonListTileWithMenu(
                    title: loan.notes?.isNotEmpty == true
                        ? loan.notes!
                        : 'Loan #${loan.id} - Rp ${loan.loanAmount.toStringAsFixed(0)}',
                    onSelected: (value) async {
                      switch (value) {
                        case 'Edit':
                          context.push('/finance/edit-loan', extra: loan);
                          break;
                        case 'Delete':
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: Text(
                                  'Are you sure you want to delete the loan "${loan.id}"?'),
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
                                .read<LoanBloc>()
                                .add(DeleteLoanEvent(loan.id));
                          }
                          break;
                      }
                    },
                  );
                },
              );
            }

            return const Center(child: Text("No loan data"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () => context.go('/finance/add-loan'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: -1),
    );
  }
}
