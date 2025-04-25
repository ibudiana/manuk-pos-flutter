// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
// import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
// import 'package:manuk_pos/core/common_widgets/text_field.dart';
// import 'package:manuk_pos/core/theme/theme.dart';
// import 'package:manuk_pos/features/transaction/domain/entities/transaction.dart'; // Update based on actual Transaction entity
// import 'package:manuk_pos/features/transaction/presentation/bloc/transaction_bloc.dart'; // Update with actual Transaction BLoC
// import 'package:manuk_pos/features/transaction/data/models/transaction_model.dart'; // Update with actual Transaction model

// class AddTransactionPage extends StatefulWidget {
//   final Transaction? transaction;

//   const AddTransactionPage({super.key, this.transaction});

//   @override
//   State<AddTransactionPage> createState() => _AddTransactionPageState();
// }

// class _AddTransactionPageState extends State<AddTransactionPage> {
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController invoiceNumberController;
//   late TextEditingController subtotalController;
//   late TextEditingController discountAmountController;
//   late TextEditingController taxAmountController;
//   late TextEditingController feeAmountController;
//   late TextEditingController shippingCostController;
//   late TextEditingController amountPaidController;
//   late TextEditingController amountReturnedController;
//   late TextEditingController shippingAddressController;
//   late TextEditingController shippingTrackingController;
//   late TextEditingController notesController;

//   String paymentStatus = 'paid'; // Default payment status
//   String transactionStatus = 'completed'; // Default transaction status

//   @override
//   void initState() {
//     super.initState();
//     final transaction = widget.transaction;
//     invoiceNumberController =
//         TextEditingController(text: transaction?.invoiceNumber ?? '');
//     subtotalController =
//         TextEditingController(text: transaction?.subtotal?.toString() ?? '');
//     discountAmountController = TextEditingController(
//         text: transaction?.discountAmount?.toString() ?? '');
//     taxAmountController =
//         TextEditingController(text: transaction?.taxAmount?.toString() ?? '');
//     feeAmountController =
//         TextEditingController(text: transaction?.feeAmount?.toString() ?? '');
//     shippingCostController = TextEditingController(
//         text: transaction?.shippingCost?.toString() ?? '');
//     amountPaidController =
//         TextEditingController(text: transaction?.amountPaid?.toString() ?? '');
//     amountReturnedController = TextEditingController(
//         text: transaction?.amountReturned?.toString() ?? '');
//     shippingAddressController =
//         TextEditingController(text: transaction?.shippingAddress ?? '');
//     shippingTrackingController =
//         TextEditingController(text: transaction?.shippingTracking ?? '');
//     notesController = TextEditingController(text: transaction?.notes ?? '');
//   }

//   @override
//   void dispose() {
//     invoiceNumberController.dispose();
//     subtotalController.dispose();
//     discountAmountController.dispose();
//     taxAmountController.dispose();
//     feeAmountController.dispose();
//     shippingCostController.dispose();
//     amountPaidController.dispose();
//     amountReturnedController.dispose();
//     shippingAddressController.dispose();
//     shippingTrackingController.dispose();
//     notesController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isEditMode = widget.transaction != null;

//     return Scaffold(
//       backgroundColor: AppTheme.thirdColor,
//       appBar: CustomAppBar(title: "Transaction Management"),
//       drawer: const AppDrawer(),
//       body: BlocListener<TransactionBloc, TransactionState>(
//         listener: (context, state) {
//           if (state is TransactionOperationSuccess) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.message)));
//             context
//                 .pushReplacement('/transaction/list'); // Navigate after success
//             context
//                 .read<TransactionBloc>()
//                 .add(GetAllTransactionEvent()); // Refresh transaction list
//           } else if (state is TransactionOperationFailure) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.message)));
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: ListView(
//               children: [
//                 Text(isEditMode ? 'Edit Transaction' : 'Add New Transaction',
//                     style: Theme.of(context).textTheme.titleLarge),
//                 const SizedBox(height: 16),
//                 CommonTextField(
//                   label: 'Invoice Number',
//                   controller: invoiceNumberController,
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 CommonTextField(
//                   label: 'Subtotal',
//                   keyboardType: TextInputType.number,
//                   controller: subtotalController,
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 CommonTextField(
//                   label: 'Discount Amount',
//                   keyboardType: TextInputType.number,
//                   controller: discountAmountController,
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 CommonTextField(
//                   label: 'Tax Amount',
//                   keyboardType: TextInputType.number,
//                   controller: taxAmountController,
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 CommonTextField(
//                   label: 'Fee Amount',
//                   keyboardType: TextInputType.number,
//                   controller: feeAmountController,
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 CommonTextField(
//                   label: 'Shipping Cost',
//                   keyboardType: TextInputType.number,
//                   controller: shippingCostController,
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 CommonTextField(
//                   label: 'Amount Paid',
//                   keyboardType: TextInputType.number,
//                   controller: amountPaidController,
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 CommonTextField(
//                   label: 'Amount Returned',
//                   keyboardType: TextInputType.number,
//                   controller: amountReturnedController,
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 CommonTextField(
//                   label: 'Shipping Address',
//                   controller: shippingAddressController,
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 CommonTextField(
//                   label: 'Shipping Tracking',
//                   controller: shippingTrackingController,
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 CommonTextField(
//                   label: 'Notes',
//                   controller: notesController,
//                   validator: (v) => v == null || v.isEmpty ? 'Required' : null,
//                 ),
//                 SwitchListTile(
//                   title: const Text('Payment Status'),
//                   value: paymentStatus == 'paid',
//                   onChanged: (value) {
//                     setState(() {
//                       paymentStatus = value ? 'paid' : 'unpaid';
//                     });
//                   },
//                 ),
//                 SwitchListTile(
//                   title: const Text('Transaction Status'),
//                   value: transactionStatus == 'completed',
//                   onChanged: (value) {
//                     setState(() {
//                       transactionStatus = value ? 'completed' : 'pending';
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       final now = DateTime.now();
//                       final transaction = TransactionModel(
//                         id: widget.transaction?.id ?? 0,
//                         invoiceNumber: invoiceNumberController.text,
//                         customerId: 1,
//                         userId: 1,
//                         branchId: 1,
//                         discountId: 1,
//                         taxId: 1,
//                         feeId: 1,
//                         invoiceDate: DateTime.parse(invoiceDateController.text),
//                         transactionDate:
//                             DateTime.parse(transactionDateController.text),
//                         dueDate: DateTime.parse(dueDateController.text),
//                         subtotal: double.parse(subtotalController.text),
//                         discountAmount:
//                             double.parse(discountAmountController.text),
//                         taxAmount: double.parse(taxAmountController.text),
//                         feeAmount: double.parse(feeAmountController.text),
//                         shippingCost: double.parse(shippingCostController.text),
//                         grandTotal: double.parse(grandTotalController.text),
//                         amountPaid: double.parse(amountPaidController.text),
//                         amountReturned:
//                             double.parse(amountReturnedController.text),
//                         paymentStatus: paymentStatus,
//                         transactionStatus: transactionStatus,
//                         pointsEarned: int.parse(pointsEarnedController.text),
//                         pointsUsed: int.parse(pointsUsedController.text),
//                         shippingAddress: shippingAddressController.text,
//                         shippingTracking: shippingTrackingController.text,
//                         notes: notesController.text,
//                         createdAt: widget.transaction?.createdAt ?? now,
//                         updatedAt: now,
//                       );

//                       final bloc = context.read<TransactionBloc>();
//                       if (isEditMode) {
//                         bloc.add(UpdateTransactionEvent(
//                             transaction.id, transaction));
//                       } else {
//                         bloc.add(AddTransactionEvent(transaction));
//                       }
//                     }
//                   },
//                   child: Text(
//                       isEditMode ? 'Update Transaction' : 'Create Transaction'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: -1),
//     );
//   }
// }
