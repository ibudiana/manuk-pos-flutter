import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/list_tile_menu.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/customer/presentation/bloc/customer_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ListCustomerPage extends StatelessWidget {
  const ListCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CustomerBloc>(
      create: (_) => sl<CustomerBloc>()..add(GetAllCustomerEvent()),
      child: BlocListener<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state is CustomerOperationSuccess) {
            context.read<CustomerBloc>().add(GetAllCustomerEvent());
          } else if (state is CustomerStateError) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Error"),
                content: const Text("List Customers failed to load"),
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
        child: const ListCustomerView(),
      ),
    );
  }
}

class ListCustomerView extends StatelessWidget {
  const ListCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Customers"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state is CustomerStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomerStateLoaded) {
              if (state.customers.isEmpty) {
                return const Center(child: Text("No customer data available"));
              }

              return ListView.separated(
                itemCount: state.customers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final customer = state.customers[index];
                  return CommonListTileWithMenu(
                    title: customer.name,
                    subtitle: customer.phone ?? customer.email ?? "-",
                    onSelected: (value) async {
                      switch (value) {
                        case 'Edit':
                          context.push('/databases/customer/edit-customer',
                              extra: customer);
                          break;
                        case 'Delete':
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: Text(
                                  'Are you sure you want to delete the customer "${customer.name}"?'),
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
                                .read<CustomerBloc>()
                                .add(DeleteCustomerEvent(customer.id));
                          }
                          break;
                      }
                    },
                  );
                },
              );
            }

            return const Center(child: Text("No customer data"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () => context.go('/databases/customer/add-customer'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: -1),
    );
  }
}
