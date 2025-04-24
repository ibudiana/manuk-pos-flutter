import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manuk_pos/core/common_widgets/bottom_nav.dart';
import 'package:manuk_pos/core/common_widgets/menu_drawer.dart';
import 'package:manuk_pos/core/common_widgets/text_field.dart';
import 'package:manuk_pos/core/common_widgets/top_nav.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/loan/domain/entities/loan.dart';
import 'package:manuk_pos/features/loan/presentation/bloc/loan_bloc.dart';
import 'package:manuk_pos/features/loan/data/models/loan_model.dart'; // sesuaikan jika perlu

class AddLoanPage extends StatefulWidget {
  final Loan? loan;

  const AddLoanPage({super.key, this.loan});

  @override
  State<AddLoanPage> createState() => _AddLoanPageState();
}

class _AddLoanPageState extends State<AddLoanPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController loanAmountController;
  late TextEditingController interestRateController;
  late TextEditingController loanTermController;
  late TextEditingController installmentAmountController;
  late TextEditingController remainingAmountController;
  late TextEditingController notesController;
  late DateTime startDate;
  late DateTime dueDate;
  String status = 'active';

  @override
  void initState() {
    super.initState();
    final loan = widget.loan;
    loanAmountController =
        TextEditingController(text: loan?.loanAmount.toString() ?? '');
    interestRateController =
        TextEditingController(text: loan?.interestRate.toString() ?? '');
    loanTermController =
        TextEditingController(text: loan?.loanTerm.toString() ?? '');
    installmentAmountController =
        TextEditingController(text: loan?.installmentAmount.toString() ?? '');
    remainingAmountController =
        TextEditingController(text: loan?.remainingAmount.toString() ?? '');
    notesController = TextEditingController(text: loan?.notes ?? '');
    startDate = loan?.startDate ?? DateTime.now();
    dueDate = loan?.dueDate ?? DateTime.now().add(const Duration(days: 365));
    status = loan?.status ?? 'active';
  }

  @override
  void dispose() {
    loanAmountController.dispose();
    interestRateController.dispose();
    loanTermController.dispose();
    installmentAmountController.dispose();
    remainingAmountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> pickDate(BuildContext context, bool isStartDate) async {
    final initialDate = isStartDate ? startDate : dueDate;
    final result = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (result != null) {
      setState(() {
        if (isStartDate) {
          startDate = result;
        } else {
          dueDate = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.loan != null;
    return Scaffold(
      backgroundColor: AppTheme.thirdColor,
      appBar: CustomAppBar(title: "Loan Management"),
      drawer: const AppDrawer(),
      body: BlocListener<LoanBloc, LoanState>(
        listener: (context, state) {
          if (state is LoanOperationSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            context.pushReplacement('/finance/list-loan');
            context.read<LoanBloc>().add(GetAllLoanEvent());
          } else if (state is LoanOperationFailure) {
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
                Text(isEditMode ? 'Edit Loan' : 'Add New Loan',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                CommonTextField(
                  label: 'Loan Amount',
                  keyboardType: TextInputType.number,
                  controller: loanAmountController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Interest Rate (%)',
                  keyboardType: TextInputType.number,
                  controller: interestRateController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Loan Term (Months)',
                  keyboardType: TextInputType.number,
                  controller: loanTermController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Installment Amount',
                  keyboardType: TextInputType.number,
                  controller: installmentAmountController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Remaining Amount',
                  keyboardType: TextInputType.number,
                  controller: remainingAmountController,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                CommonTextField(
                  label: 'Notes',
                  controller: notesController,
                ),
                ListTile(
                  title: const Text('Start Date'),
                  subtitle: Text('${startDate.toLocal()}'.split(' ')[0]),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => pickDate(context, true),
                ),
                ListTile(
                  title: const Text('Due Date'),
                  subtitle: Text('${dueDate.toLocal()}'.split(' ')[0]),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => pickDate(context, false),
                ),
                DropdownButtonFormField<String>(
                  value: status,
                  items: const [
                    DropdownMenuItem(value: 'active', child: Text('Active')),
                    DropdownMenuItem(value: 'closed', child: Text('Closed')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => status = value);
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Status'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final now = DateTime.now();
                      final loan = LoanModel(
                        id: widget.loan?.id ?? 0,
                        customerId: widget.loan?.customerId ??
                            1, // bisa pilih customer juga
                        loanAmount: double.parse(loanAmountController.text),
                        interestRate: double.parse(interestRateController.text),
                        loanTerm: int.parse(loanTermController.text),
                        installmentAmount:
                            double.parse(installmentAmountController.text),
                        remainingAmount:
                            double.parse(remainingAmountController.text),
                        startDate: startDate,
                        dueDate: dueDate,
                        status: status,
                        notes: notesController.text,
                        createdAt: widget.loan?.createdAt ?? now,
                        updatedAt: now,
                      );

                      final bloc = context.read<LoanBloc>();
                      if (isEditMode) {
                        bloc.add(UpdateLoanEvent(loan.id, loan));
                      } else {
                        bloc.add(AddLoanEvent(loan));
                      }
                    }
                  },
                  child: Text(isEditMode ? 'Update Loan' : 'Create Loan'),
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
