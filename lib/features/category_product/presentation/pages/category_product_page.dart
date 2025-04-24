import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/text_field.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/category_product/domain/entities/category_product_.dart';
import 'package:manuk_pos/features/category_product/presentation/bloc/category_product_bloc.dart';

class AddCategoryPage extends StatefulWidget {
  final Category? category;

  const AddCategoryPage({super.key, this.category});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController codeController;
  late TextEditingController descriptionController;
  late TextEditingController levelController;
  late TextEditingController pathController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.category?.name ?? '');
    codeController = TextEditingController(text: widget.category?.code ?? '');
    descriptionController =
        TextEditingController(text: widget.category?.description ?? '');
    levelController =
        TextEditingController(text: widget.category?.level?.toString() ?? '');
    pathController = TextEditingController(text: widget.category?.path ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    descriptionController.dispose();
    levelController.dispose();
    pathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.category != null;

    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
      drawer: const AppDrawer(),
      body: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pushReplacement('/setting/list-category');
            context.read<CategoryBloc>().add(GetAllCategoryEvent());
          } else if (state is CategoryOperationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  isEditMode ? 'Edit Category' : 'Add New Category',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  label: 'Category Name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Category Name is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Category Code',
                  controller: codeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Category Code is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Description',
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Level',
                  controller: levelController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Level is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Path',
                  controller: pathController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Path is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final category = Category(
                        id: widget.category?.id ?? 0,
                        name: nameController.text,
                        code: codeController.text,
                        description: descriptionController.text,
                        level: int.parse(levelController.text),
                        path: pathController.text,
                        createdAt: widget.category?.createdAt ?? DateTime.now(),
                        updatedAt: widget.category?.updatedAt ?? DateTime.now(),
                      );

                      final bloc = context.read<CategoryBloc>();
                      if (isEditMode) {
                        bloc.add(UpdateCategoryEvent(category.id, category));
                      } else {
                        bloc.add(AddCategoryEvent(category));
                      }
                    }
                  },
                  child:
                      Text(isEditMode ? 'Update Category' : 'Create Category'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: -1),
    );
  }
}
