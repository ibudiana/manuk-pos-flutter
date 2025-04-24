import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/text_field.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/role/domain/entities/role.dart';
import 'package:manuk_pos/features/role/presentation/bloc/role_bloc.dart';

class AddRolePage extends StatefulWidget {
  final Role? role;

  const AddRolePage({super.key, this.role});

  @override
  State<AddRolePage> createState() => _AddRolePageState();
}

class _AddRolePageState extends State<AddRolePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController roleNameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    roleNameController =
        TextEditingController(text: widget.role?.roleName ?? '');
    descriptionController =
        TextEditingController(text: widget.role?.description ?? '');
  }

  @override
  void dispose() {
    roleNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.role != null;

    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
      drawer: const AppDrawer(),
      body: BlocListener<RoleBloc, RoleState>(
        listener: (context, state) {
          if (state is RoleOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pushReplacement('/setting/roles');
            context.read<RoleBloc>().add(GetAllRoleEvent());
          } else if (state is RoleOperationFailure) {
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
                  isEditMode ? 'Edit Role' : 'Add New Role',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  label: 'Role Name',
                  controller: roleNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Role Name is required';
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
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final role = Role(
                        id: widget.role?.id ?? 0,
                        roleName: roleNameController.text,
                        description: descriptionController.text,
                      );

                      final bloc = context.read<RoleBloc>();
                      if (isEditMode) {
                        bloc.add(UpdateRoleEvent(role.id, role));
                      } else {
                        bloc.add(AddRoleEvent(role));
                      }
                    }
                  },
                  child: Text(isEditMode ? 'Update Role' : 'Create Role'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}
