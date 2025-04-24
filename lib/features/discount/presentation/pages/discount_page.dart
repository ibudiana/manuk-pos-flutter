import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/text_field.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/discount/domain/entities/discount.dart';
import 'package:manuk_pos/features/discount/presentation/bloc/discount_bloc.dart';

class AddDiscountPage extends StatefulWidget {
  final Discount? discount;

  const AddDiscountPage({super.key, this.discount});

  @override
  State<AddDiscountPage> createState() => _AddDiscountPageState();
}

class _AddDiscountPageState extends State<AddDiscountPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController codeController;
  late TextEditingController descriptionController;
  late TextEditingController discountTypeController;
  late TextEditingController discountValueController;
  late TextEditingController minPurchaseController;
  late TextEditingController maxDiscountController;
  late TextEditingController usageLimitController;
  late TextEditingController usageCountController;

  late DateTime startDate;
  late DateTime endDate;
  bool isActive = true;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.discount?.name ?? '');
    codeController = TextEditingController(text: widget.discount?.code ?? '');
    descriptionController =
        TextEditingController(text: widget.discount?.description ?? '');
    discountTypeController =
        TextEditingController(text: widget.discount?.discountType ?? '');
    discountValueController = TextEditingController(
        text: widget.discount?.discountValue.toString() ?? '');
    minPurchaseController = TextEditingController(
        text: widget.discount?.minPurchase.toString() ?? '');
    maxDiscountController = TextEditingController(
        text: widget.discount?.maxDiscount.toString() ?? '');
    usageLimitController = TextEditingController(
        text: widget.discount?.usageLimit.toString() ?? '');
    usageCountController = TextEditingController(
        text: widget.discount?.usageCount.toString() ?? '');

    startDate = widget.discount?.startDate ?? DateTime.now();
    endDate =
        widget.discount?.endDate ?? DateTime.now().add(Duration(days: 30));
    isActive = widget.discount?.isActive ?? true;
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    descriptionController.dispose();
    discountTypeController.dispose();
    discountValueController.dispose();
    minPurchaseController.dispose();
    maxDiscountController.dispose();
    usageLimitController.dispose();
    usageCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.discount != null;

    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Manuk POS"),
      drawer: const AppDrawer(),
      body: BlocListener<DiscountBloc, DiscountState>(
        listener: (context, state) {
          if (state is DiscountOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pushReplacement('/setting/discounts');
            context.read<DiscountBloc>().add(GetAllDiscountEvent());
          } else if (state is DiscountOperationFailure) {
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
                  isEditMode ? 'Edit Discount' : 'Add New Discount',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                CommonTextField(
                  label: 'Discount Name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Discount Name is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Code',
                  controller: codeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Code is required';
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
                  label: 'Discount Type',
                  controller: discountTypeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Discount Type is required';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Discount Value',
                  controller: discountValueController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Discount Value is required';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid value';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Minimum Purchase',
                  controller: minPurchaseController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Minimum Purchase is required';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Max Discount',
                  controller: maxDiscountController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Max Discount is required';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Usage Limit',
                  controller: usageLimitController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Usage Limit is required';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                CommonTextField(
                  label: 'Usage Count',
                  controller: usageCountController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Usage Count is required';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
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
                      final discount = Discount(
                        id: widget.discount?.id ?? 0,
                        categoryId: widget.discount?.categoryId ?? 0,
                        productId: widget.discount?.productId ?? 0,
                        customerId: widget.discount?.customerId ?? 0,
                        name: nameController.text,
                        code: codeController.text,
                        description: descriptionController.text,
                        discountType: discountTypeController.text,
                        discountValue:
                            double.parse(discountValueController.text),
                        minPurchase: double.parse(minPurchaseController.text),
                        maxDiscount: double.parse(maxDiscountController.text),
                        startDate: startDate,
                        endDate: endDate,
                        usageLimit: int.parse(usageLimitController.text),
                        usageCount: int.parse(usageCountController.text),
                        isActive: isActive,
                        appliesTo: 'Product', // Modify as per your logic
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );

                      final bloc = context.read<DiscountBloc>();
                      if (isEditMode) {
                        bloc.add(UpdateDiscountEvent(discount.id, discount));
                      } else {
                        bloc.add(AddDiscountEvent(discount));
                      }
                    }
                  },
                  child:
                      Text(isEditMode ? 'Update Discount' : 'Create Discount'),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}
