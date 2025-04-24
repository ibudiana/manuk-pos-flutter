import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/text_field.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/fee/domain/entities/fee.dart'; // Update based on actual Fee entity
import 'package:manuk_pos/features/fee/presentation/bloc/fee_bloc.dart'; // Update with actual Fee BLoC
import 'package:manuk_pos/features/fee/data/models/fee_model.dart'; // Update with actual Fee model

class AddFeePage extends StatefulWidget {
  final Fee? fee;

  const AddFeePage({super.key, this.fee});

  @override
  State<AddFeePage> createState() => _AddFeePageState();
}

class _AddFeePageState extends State<AddFeePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController feeNameController;
  late TextEditingController feeValueController;
  String feeType = 'Shipping'; // Default fee type
  bool isDefault = false;
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    final fee = widget.fee;
    feeNameController = TextEditingController(text: fee?.name ?? '');
    feeValueController =
        TextEditingController(text: fee?.feeValue.toString() ?? '');
    feeType = fee?.feeType ?? 'Shipping';
    isDefault = fee?.isDefault ?? false;
    isActive = fee?.isActive ?? true;
  }

  @override
  void dispose() {
    feeNameController.dispose();
    feeValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.fee != null;

    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Fee Management"),
      drawer: const AppDrawer(),
      body: BlocListener<FeeBloc, FeeState>(
        listener: (context, state) {
          if (state is FeeOperationSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            context
                .pushReplacement('/finance/list-fee'); // Navigate after success
            context.read<FeeBloc>().add(GetAllFeeEvent()); // Refresh fee list
          } else if (state is FeeOperationFailure) {
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
                Text(isEditMode ? 'Edit Fee' : 'Add New Fee',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                CommonTextField(
                  label: 'Fee Name',
                  controller: feeNameController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Fee Value',
                  keyboardType: TextInputType.number,
                  controller: feeValueController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                // DropdownButtonFormField<String>(
                //   value: feeType,
                //   items: const [
                //     DropdownMenuItem(
                //         value: 'Shipping', child: Text('Shipping')),
                //     DropdownMenuItem(value: 'Tax', child: Text('Tax')),
                //     DropdownMenuItem(
                //         value: 'Discount', child: Text('Discount')),
                //   ],
                //   onChanged: (value) {
                //     if (value != null) {
                //       setState(() {
                //         feeType = value;
                //       });
                //     }
                //   },
                //   decoration: const InputDecoration(labelText: 'Fee Type'),
                //   // Adding validation for null or empty feeType
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please select a fee type';
                //     }
                //     return null;
                //   },
                // ),
                SwitchListTile(
                  title: const Text('Default Fee'),
                  value: isDefault,
                  onChanged: (value) {
                    setState(() {
                      isDefault = value;
                    });
                  },
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
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final now = DateTime.now();
                      final fee = FeeModel(
                        id: widget.fee?.id ?? 0,
                        name: feeNameController.text,
                        feeType: feeType,
                        feeValue: double.parse(feeValueController.text),
                        isDefault: isDefault,
                        isActive: isActive,
                        createdAt: widget.fee?.createdAt ?? now,
                        updatedAt: now,
                      );

                      final bloc = context.read<FeeBloc>();
                      if (isEditMode) {
                        bloc.add(UpdateFeeEvent(fee.id, fee));
                      } else {
                        bloc.add(AddFeeEvent(fee));
                      }
                    }
                  },
                  child: Text(isEditMode ? 'Update Fee' : 'Create Fee'),
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
