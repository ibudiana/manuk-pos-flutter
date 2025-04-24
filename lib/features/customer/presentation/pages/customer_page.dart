import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/text_field.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/customer/data/models/customer_model.dart';
import 'package:manuk_pos/features/customer/domain/entities/customer.dart';
import 'package:manuk_pos/features/customer/presentation/bloc/customer_bloc.dart';

class AddCustomerPage extends StatefulWidget {
  final Customer? customer;

  const AddCustomerPage({super.key, this.customer});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController codeController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController postalCodeController;
  late TextEditingController birthdateController;
  late TextEditingController joinDateController;
  late TextEditingController customerTypeController;
  late TextEditingController creditLimitController;
  late TextEditingController currentBalanceController;
  late TextEditingController taxIdController;
  late TextEditingController notesController;

  bool isActive = true;

  @override
  void initState() {
    super.initState();
    final customer = widget.customer;
    codeController = TextEditingController(text: customer?.code ?? '');
    nameController = TextEditingController(text: customer?.name ?? '');
    phoneController = TextEditingController(text: customer?.phone ?? '');
    emailController = TextEditingController(text: customer?.email ?? '');
    addressController = TextEditingController(text: customer?.address ?? '');
    cityController = TextEditingController(text: customer?.city ?? '');
    postalCodeController =
        TextEditingController(text: customer?.postalCode ?? '');
    birthdateController = TextEditingController(
      text: customer?.birthdate != null
          ? DateFormat('yyyy-MM-dd').format(customer!.birthdate!)
          : '',
    );
    joinDateController = TextEditingController(
      text: customer?.joinDate != null
          ? DateFormat('yyyy-MM-dd').format(customer!.joinDate!)
          : '',
    );
    customerTypeController =
        TextEditingController(text: customer?.customerType ?? 'regular');
    creditLimitController =
        TextEditingController(text: customer?.creditLimit.toString() ?? '0');
    currentBalanceController =
        TextEditingController(text: customer?.currentBalance.toString() ?? '0');
    taxIdController =
        TextEditingController(text: customer?.taxId.toString() ?? '0');
    notesController = TextEditingController(text: customer?.notes ?? '');
    isActive = customer?.isActive ?? true;
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    birthdateController.dispose();
    joinDateController.dispose();
    customerTypeController.dispose();
    creditLimitController.dispose();
    currentBalanceController.dispose();
    taxIdController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.customer != null;

    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Customer Management"),
      drawer: const AppDrawer(),
      body: BlocListener<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state is CustomerOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pushReplacement('/databases/customer/list-customer');
            context.read<CustomerBloc>().add(GetAllCustomerEvent());
          } else if (state is CustomerOperationFailure) {
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
                  isEditMode ? 'Edit Customer' : 'Add New Customer',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  label: 'Customer Code',
                  controller: codeController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Customer Name',
                  controller: nameController,
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
                  label: 'City',
                  controller: cityController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Postal Code',
                  controller: postalCodeController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Birthdate',
                  controller: birthdateController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Join Date',
                  controller: joinDateController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Customer Type',
                  controller: customerTypeController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Credit Limit',
                  keyboardType: TextInputType.number,
                  controller: creditLimitController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Current Balance',
                  keyboardType: TextInputType.number,
                  controller: currentBalanceController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Tax ID',
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
                  controller: notesController,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final now = DateTime.now();
                      final birthdate =
                          DateTime.tryParse(birthdateController.text) ?? now;
                      final joinDate =
                          DateTime.tryParse(joinDateController.text) ?? now;

                      if (birthdate == null || joinDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid date format')),
                        );
                        return;
                      }

                      final customer = CustomerModel(
                        id: widget.customer?.id ?? 0,
                        taxId: int.tryParse(taxIdController.text) ?? 0,
                        code: codeController.text,
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        address: addressController.text,
                        city: cityController.text,
                        postalCode: postalCodeController.text,
                        birthdate: birthdate,
                        joinDate: joinDate,
                        customerType: customerTypeController.text,
                        creditLimit:
                            double.tryParse(creditLimitController.text) ?? 0.0,
                        currentBalance:
                            double.tryParse(currentBalanceController.text) ??
                                0.0,
                        isActive: isActive,
                        notes: notesController.text,
                        createdAt: widget.customer?.createdAt ?? now,
                        updatedAt: now,
                      );

                      final bloc = context.read<CustomerBloc>();
                      if (widget.customer != null && widget.customer!.id != 0) {
                        bloc.add(UpdateCustomerEvent(customer.id, customer));
                      } else {
                        bloc.add(AddCustomerEvent(customer));
                      }
                    }
                  },
                  child:
                      Text(isEditMode ? 'Update Customer' : 'Create Customer'),
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
