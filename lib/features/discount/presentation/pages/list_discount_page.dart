import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/list_tile_menu.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/discount/presentation/bloc/discount_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ListDiscountPage extends StatelessWidget {
  const ListDiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiscountBloc>(
      create: (_) => sl<DiscountBloc>()..add(GetAllDiscountEvent()),
      child: BlocListener<DiscountBloc, DiscountState>(
        listener: (context, state) {
          if (state is DiscountOperationSuccess) {
            context.read<DiscountBloc>().add(GetAllDiscountEvent());
          }
        },
        child: const ListDiscountView(),
      ),
    );
  }
}

class ListDiscountView extends StatelessWidget {
  const ListDiscountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Discounts"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<DiscountBloc, DiscountState>(
          builder: (context, state) {
            if (state is DiscountStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DiscountStateLoaded) {
              return ListView.separated(
                itemCount: state.discounts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final discount = state.discounts[index];
                  return CommonListTileWithMenu(
                    title: discount.name,
                    subtitle:
                        'Code: ${discount.code} - ${discount.discountValue}%',
                    onSelected: (value) async {
                      if (value == 'Edit') {
                        context.push('/setting/edit-discount', extra: discount);
                      } else if (value == 'Delete') {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: Text(
                                'Are you sure you want to delete the discount ${discount.name}?'),
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
                          // Belum ada delete di discount_bloc, nanti bisa ditambahkan
                          // context.read<DiscountBloc>().add(DeleteDiscountEvent(discount.id));
                        }
                      }
                    },
                  );
                },
              );
            } else if (state is DiscountStateError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text("No discount data"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () => context.go('/setting/add-discount'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: -1),
    );
  }
}
