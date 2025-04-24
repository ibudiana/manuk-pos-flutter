import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/text_field.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/tax/domain/entities/tax.dart';
import 'package:manuk_pos/features/tax/presentation/bloc/tax_bloc.dart';

class AddTaxPage extends StatefulWidget {
  final Tax? tax;

  const AddTaxPage({super.key, this.tax});

  @override
  State<AddTaxPage> createState() => _AddTaxPageState();
}

class _AddTaxPageState extends State<AddTaxPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController rateController;
  bool isDefault = false;
  bool isActive = true;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.tax?.name ?? '');
    rateController =
        TextEditingController(text: widget.tax?.rate.toString() ?? '');
    isDefault = widget.tax?.isDefault ?? false;
    isActive = widget.tax?.isActive ?? true;
  }

  @override
  void dispose() {
    nameController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.tax != null;

    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
      drawer: const AppDrawer(),
      body: BlocListener<TaxBloc, TaxState>(
        listener: (context, state) {
          if (state is TaxOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pushReplacement('/finance/list-tax');
            context.read<TaxBloc>().add(GetAllTaxEvent());
          } else if (state is TaxOperationFailure) {
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
                  isEditMode ? 'Edit Tax' : 'Add New Tax',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  label: 'Tax Name',
                  controller: nameController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Tax name is required'
                      : null,
                ),
                CommonTextField(
                  label: 'Tax Rate (%)',
                  keyboardType: TextInputType.number,
                  controller: rateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tax rate is required';
                    }
                    final rate = int.tryParse(value);
                    if (rate == null || rate < 0) {
                      return 'Enter a valid rate';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  title: const Text('Is Default'),
                  value: isDefault,
                  onChanged: (value) => setState(() => isDefault = value),
                ),
                SwitchListTile(
                  title: const Text('Is Active'),
                  value: isActive,
                  onChanged: (value) => setState(() => isActive = value),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final now = DateTime.now();
                      final tax = Tax(
                        id: widget.tax?.id ?? 0,
                        name: nameController.text,
                        rate: int.parse(rateController.text),
                        isDefault: isDefault,
                        isActive: isActive,
                        createdAt: widget.tax?.createdAt ?? now,
                        updatedAt: now,
                      );

                      final bloc = context.read<TaxBloc>();
                      if (isEditMode) {
                        bloc.add(UpdateTaxEvent(tax.id, tax));
                      } else {
                        bloc.add(AddTaxEvent(tax));
                      }
                    }
                  },
                  child: Text(isEditMode ? 'Update Tax' : 'Create Tax'),
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
