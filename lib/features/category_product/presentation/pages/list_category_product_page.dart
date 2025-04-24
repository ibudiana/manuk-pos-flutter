import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/list_tile_menu.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/category_product/presentation/bloc/category_product_bloc.dart';
import 'package:manuk_pos/service_locator.dart';

class ListCategoryPage extends StatelessWidget {
  const ListCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (_) => sl<CategoryBloc>()..add(GetAllCategoryEvent()),
      child: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryOperationSuccess) {
            context.read<CategoryBloc>().add(GetAllCategoryEvent());
          }
        },
        child: const ListCategoryView(),
      ),
    );
  }
}

class ListCategoryView extends StatelessWidget {
  const ListCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Categories"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryStateLoaded) {
              return ListView.separated(
                itemCount: state.categories.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return CommonListTileWithMenu(
                    title: category.name,
                    onSelected: (value) async {
                      if (value == 'Edit') {
                        context.push(
                            '/inventory/product/category/edit-category',
                            extra: category);
                      } else if (value == 'Delete') {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: Text(
                                'Are you sure you want to delete the category ${category.name}?'),
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
                          context
                              .read<CategoryBloc>()
                              .add(DeleteCategoryEvent(category.id));
                        }
                      }
                    },
                  );
                },
              );
            } else if (state is CategoryStateError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text("No category data"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () => context.go('/inventory/product/category/add-category'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: -1),
    );
  }
}
