import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/text_field.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/supplier/data/models/supplier_model.dart';
import 'package:manuk_pos/features/supplier/domain/entities/supplier.dart';
import 'package:manuk_pos/features/supplier/presentation/bloc/supplier_bloc.dart';

class AddSupplierPage extends StatefulWidget {
  final Supplier? supplier;

  const AddSupplierPage({super.key, this.supplier});

  @override
  State<AddSupplierPage> createState() => _AddSupplierPageState();
}

class _AddSupplierPageState extends State<AddSupplierPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController codeController;
  late TextEditingController nameController;
  late TextEditingController contactPersonController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController paymentTermsController;
  late TextEditingController taxIdController; // Added taxId controller
  bool isActive = true;
  late String notes;

  @override
  void initState() {
    super.initState();
    final supplier = widget.supplier;
    codeController = TextEditingController(text: supplier?.code ?? '');
    nameController = TextEditingController(text: supplier?.name ?? '');
    contactPersonController =
        TextEditingController(text: supplier?.contactPerson ?? '');
    phoneController = TextEditingController(text: supplier?.phone ?? '');
    emailController = TextEditingController(text: supplier?.email ?? '');
    addressController = TextEditingController(text: supplier?.address ?? '');
    paymentTermsController =
        TextEditingController(text: supplier?.paymentTerms.toString() ?? '');
    taxIdController = TextEditingController(
        text: supplier?.taxId?.toString() ?? ''); // Initialize taxId
    isActive = supplier?.isActive ?? true;
    notes = supplier?.notes ?? '';
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    contactPersonController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    paymentTermsController.dispose();
    taxIdController.dispose(); // Dispose taxId controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.supplier != null;

    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Supplier Management"),
      drawer: const AppDrawer(),
      body: BlocListener<SupplierBloc, SupplierState>(
        listener: (context, state) {
          if (state is SupplierOperationSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            context.pushReplacement(
                '/databases/supplier/list-supplier'); // Navigate after success
            context
                .read<SupplierBloc>()
                .add(GetAllSupplierEvent()); // Refresh supplier list
          } else if (state is SupplierOperationFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(isEditMode ? 'Edit Supplier' : 'Add New Supplier',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                CommonTextField(
                  label: 'Supplier Code',
                  controller: codeController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Supplier Name',
                  controller: nameController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Contact Person',
                  controller: contactPersonController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Phone',
                  controller: phoneController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Email',
                  controller: emailController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Address',
                  controller: addressController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Payment Terms',
                  keyboardType: TextInputType.number,
                  controller: paymentTermsController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Tax ID', // Added field for Tax ID
                  keyboardType: TextInputType.number,
                  controller: taxIdController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                SwitchListTile(
                  title: const Text('Active'),
                  value: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = value;
                    });
                  },
                ),
                CommonTextField(
                    label: 'Notes',
                    controller: TextEditingController(text: notes)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final now = DateTime.now();
                      final supplier = SupplierModel(
                        id: widget.supplier?.id ?? 0,
                        code: codeController.text,
                        name: nameController.text,
                        contactPerson: contactPersonController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        address: addressController.text,
                        paymentTerms: int.parse(paymentTermsController.text),
                        taxId: int.tryParse(taxIdController.text) ??
                            0, // Convert taxId to integer
                        isActive: isActive,
                        notes: notes,
                        createdAt: widget.supplier?.createdAt ?? now,
                        updatedAt: now,
                      );

                      final bloc = context.read<SupplierBloc>();
                      if (isEditMode) {
                        bloc.add(UpdateSupplierEvent(supplier.id, supplier));
                      } else {
                        bloc.add(AddSupplierEvent(supplier));
                      }
                    }
                  },
                  child:
                      Text(isEditMode ? 'Update Supplier' : 'Create Supplier'),
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
