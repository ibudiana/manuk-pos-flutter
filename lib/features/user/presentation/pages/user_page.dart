import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/text_field.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/user/domain/entities/user.dart';
import 'package:manuk_pos/features/user/presentation/bloc/user_bloc.dart';

class AddUserPage extends StatefulWidget {
  final User? user; // jika null = add user, jika tidak = edit user

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

  final branches = ['Manuk 1', 'Manuk 2'];
  final roles = ['Admin', 'Staff'];

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.user?.name ?? '');
    usernameController =
        TextEditingController(text: widget.user?.username ?? '');
    emailController = TextEditingController(text: widget.user?.email ?? '');
    passwordController = TextEditingController(); // kosongkan saat edit
    phoneController = TextEditingController(text: widget.user?.phone ?? '');

    selectedBranch =
        widget.user?.branchId != null ? 'Manuk ${widget.user!.branchId}' : null;
    selectedRole = widget.user?.roleId != null
        ? (widget.user!.roleId == 1 ? 'Admin' : 'Staff')
        : null;
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
            // Show success SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context
                .pushReplacement('/setting/list-user'); // Redirect to list-user
            // Trigger event to get updated users list
            context
                .read<UserBloc>()
                .add(GetAllUsersEvent()); // Refresh user list
          } else if (state is UserOperationFailure) {
            // Show failure SnackBar
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
                CommonTextField('Name',
                    controller: nameController, label: 'Name'),
                CommonTextField('Username',
                    controller: usernameController, label: 'Username'),
                CommonTextField('Email',
                    controller: emailController, label: 'Email'),
                if (!isEditMode)
                  CommonTextField('Password',
                      controller: passwordController, label: 'Password'),
                CommonTextField('Phone',
                    controller: phoneController, label: 'Phone'),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Branch Option'),
                  value: selectedBranch,
                  items: branches
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => selectedBranch = value),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Role Option'),
                  value: selectedRole,
                  items: roles
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => selectedRole = value),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final branchId = selectedBranch == 'Manuk 1'
                          ? 1
                          : (selectedBranch == 'Manuk 2' ? 2 : null);

                      final roleId = selectedRole == 'Admin'
                          ? 1
                          : (selectedRole == 'Staff' ? 2 : null);

                      if (branchId == null || roleId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please select valid branch and role'),
                          ),
                        );
                        return;
                      }

                      final user = User(
                        id: widget.user?.id ?? 0, // ID untuk edit atau tambah
                        name: nameController.text,
                        username: usernameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        branchId: branchId, // gunakan branchId sebagai int
                        roleId: roleId, // gunakan roleId sebagai int
                      );

                      final userBloc = context.read<UserBloc>();
                      if (widget.user != null) {
                        // Jika mode edit, kirim ID dan user untuk update
                        userBloc.add(UpdateUserEvent(user.id, user));
                      } else {
                        // Jika mode tambah, kirim user untuk tambah
                        userBloc.add(AddUserEvent(user));
                      }

                      print('Branch ID: $branchId');
                      print('Role ID: $roleId');
                    }
                  },
                  child:
                      Text(widget.user != null ? 'Update User' : 'Create User'),
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
