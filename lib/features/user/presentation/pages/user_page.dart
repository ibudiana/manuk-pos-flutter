import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/text_field.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/branch/domain/entities/branch.dart';
import 'package:manuk_pos/features/branch/presentation/bloc/branch_bloc.dart';
import 'package:manuk_pos/features/role/domain/entities/role.dart';
import 'package:manuk_pos/features/role/presentation/bloc/role_bloc.dart';
import 'package:manuk_pos/features/user/domain/entities/user.dart';
import 'package:manuk_pos/features/user/presentation/bloc/user_bloc.dart';

// import statements tetap
class AddUserPage extends StatefulWidget {
  final User? user;

  const AddUserPage({super.key, this.user});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;

  String? selectedBranch;
  String? selectedRole;
  bool? isActive;

  List<Branch> branches = [];
  List<Role> roles = [];
  // final roles = ['Admin', 'Staff'];

  @override
  void initState() {
    super.initState();
    context.read<BranchBloc>().add(GetAllBranchEvent());
    context.read<RoleBloc>().add(GetAllRoleEvent());

    nameController = TextEditingController(text: widget.user?.name ?? '');
    usernameController =
        TextEditingController(text: widget.user?.username ?? '');
    emailController = TextEditingController(text: widget.user?.email ?? '');
    passwordController = TextEditingController();
    phoneController = TextEditingController(text: widget.user?.phone ?? '');

    selectedBranch =
        widget.user?.branchId != null ? widget.user!.branchId.toString() : null;
    selectedRole =
        widget.user?.roleId != null ? widget.user!.roleId.toString() : null;
    isActive = widget.user?.isActive ?? true;
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.user != null;

    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
      drawer: const AppDrawer(),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pushReplacement('/setting/list-user');
            context.read<UserBloc>().add(GetAllUsersEvent());
          } else if (state is UserOperationFailure) {
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
                  isEditMode ? 'Edit User' : 'Add New User',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  label: 'Name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Username',
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) return 'Invalid email';
                    return null;
                  },
                ),
                if (!isEditMode)
                  CommonTextField(
                    label: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                CommonTextField(
                  label: 'Phone',
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Only numbers are allowed';
                    }
                    if (value.length < 10) {
                      return 'Phone number must be at least 10 digits';
                    }
                    return null;
                  },
                ),
                // Add BlocBuilder for Branch data
                BlocBuilder<BranchBloc, BranchState>(
                  builder: (context, state) {
                    if (state is BranchStateLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is BranchStateLoaded) {
                      branches = state.branches; // Store branches
                      return DropdownButtonFormField<String>(
                        decoration:
                            const InputDecoration(labelText: 'Branch Option'),
                        value: selectedBranch,
                        items: branches
                            .map((branch) => DropdownMenuItem(
                                  value: branch.id.toString(),
                                  child: Text(branch.name),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => selectedBranch = value),
                      );
                    } else if (state is BranchOperationFailure) {
                      return Text(state.message);
                    }
                    return const Text('No Branch Data');
                  },
                ),
                BlocBuilder<RoleBloc, RoleState>(
                  builder: (context, state) {
                    if (state is RoleStateLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is RoleStateLoaded) {
                      roles = state.roles; // Menyimpan roles yang sudah dimuat
                      return DropdownButtonFormField<String>(
                        decoration:
                            const InputDecoration(labelText: 'Role Option'),
                        value: selectedRole,
                        items: roles
                            .map((role) => DropdownMenuItem(
                                  value: role.id.toString(),
                                  child: Text(role.roleName),
                                ))
                            .toList(),
                        onChanged: (value) => setState(() {
                          selectedRole = value; // Memperbarui selectedRole
                        }),
                      );
                    } else if (state is RoleOperationFailure) {
                      return Text(state.message);
                    }
                    return const Text('No Role Data');
                  },
                ),

                SwitchListTile(
                  title: const Text('User is Active'),
                  value: isActive ?? false,
                  onChanged: (value) {
                    setState(() {
                      isActive = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Check if selectedBranch is not null or empty
                      if (selectedBranch == null || selectedBranch!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please select a valid branch')),
                        );
                        return;
                      }

                      // Find the selected branch ID based on the selectedBranch value
                      final branch = branches.firstWhere(
                        (branch) => branch.id.toString() == selectedBranch,
                      );

                      final branchId = branch.id;

                      // Check if selectedRole is not null or empty
                      if (selectedRole == null || selectedRole!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please select a valid role')),
                        );
                        return;
                      }

                      // Find the selected role ID based on the selectedRole value
                      final role = roles.firstWhere(
                        (role) => role.id.toString() == selectedRole,
                      );

                      final roleId = role.id;

                      final user = User(
                        id: widget.user?.id ?? 0,
                        name: nameController.text,
                        username: usernameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        branchId: branchId,
                        roleId: roleId,
                        isActive: isActive ?? true,
                        loginCount: widget.user?.loginCount ?? 0,
                        createdAt: widget.user?.createdAt ?? DateTime.now(),
                        updatedAt: DateTime.now(),
                      );

                      final userBloc = context.read<UserBloc>();
                      if (isEditMode) {
                        userBloc.add(UpdateUserEvent(user.id, user));
                      } else {
                        userBloc.add(AddUserEvent(user));
                      }
                    }
                  },
                  child: Text(isEditMode ? 'Update User' : 'Create User'),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
