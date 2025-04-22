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

class AddBranchPage extends StatefulWidget {
  final Branch? branch;

  const AddBranchPage({super.key, this.branch});

  @override
  State<AddBranchPage> createState() => _AddBranchPageState();
}

class _AddBranchPageState extends State<AddBranchPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController codeController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  bool isMainBranch = false;
  bool isActive = true;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.branch?.name ?? '');
    codeController = TextEditingController(text: widget.branch?.code ?? '');
    addressController =
        TextEditingController(text: widget.branch?.address ?? '');
    phoneController = TextEditingController(text: widget.branch?.phone ?? '');
    emailController = TextEditingController(text: widget.branch?.email ?? '');

    isMainBranch = widget.branch?.isMainBranch ?? false;
    isActive = widget.branch?.isActive ?? true;
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.branch != null;

    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
      drawer: const AppDrawer(),
      body: BlocListener<BranchBloc, BranchState>(
        listener: (context, state) {
          if (state is BranchOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pushReplacement('/setting/branches');
            context.read<BranchBloc>().add(GetAllBranchEvent());
          } else if (state is BranchOperationFailure) {
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
                  isEditMode ? 'Edit Branch' : 'Add New Branch',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                CommonTextField('Branch Name',
                    controller: nameController, label: 'Branch Name'),
                CommonTextField('Code',
                    controller: codeController, label: 'Code'),
                CommonTextField('Address',
                    controller: addressController, label: 'Address'),
                CommonTextField('Phone',
                    controller: phoneController, label: 'Phone'),
                CommonTextField('Email',
                    controller: emailController, label: 'Email'),
                SwitchListTile(
                  title: const Text('Main Branch?'),
                  value: isMainBranch,
                  onChanged: (val) {
                    setState(() => isMainBranch = val);
                  },
                ),
                SwitchListTile(
                  title: const Text('Active?'),
                  value: isActive,
                  onChanged: (val) {
                    setState(() => isActive = val);
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final branch = Branch(
                        id: widget.branch?.id ?? 0,
                        code: codeController.text,
                        name: nameController.text,
                        address: addressController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        isMainBranch: isMainBranch,
                        isActive: isActive,
                      );

                      final bloc = context.read<BranchBloc>();
                      if (isEditMode) {
                        bloc.add(UpdateBranchEvent(branch.id, branch));
                      } else {
                        bloc.add(AddBranchEvent(branch));
                      }
                    }
                  },
                  child: Text(isEditMode ? 'Update Branch' : 'Create Branch'),
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
