import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/firebase_resources.dart';
import 'package:gym/core/resources/functions.dart';
import 'package:gym/core/resources/style_resources.dart';

import 'package:gym/presentation/bloc/expenses/expenses_bloc.dart';
import 'package:gym/presentation/widgets/primary_button.dart';
import 'package:gym/presentation/widgets/text_input_form_field.dart';
import 'package:gym/service/model/fees_payment_model.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpensesScreen> {
  final _expenseNameController = TextEditingController();
  final _amountController = TextEditingController();
  final _nameExpenserController = TextEditingController();
  final _remarksController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text('Record Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 6.h,
                  child: TextInputFormField(
                      controller: _expenseNameController,
                      hint: 'Expense Name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Expense name is required';
                        }
                        return null;
                      }),
                ),
                SizedBox(height: 3.h),
                SizedBox(
                  height: 6.h,
                  child: TextInputFormField(
                      controller: _amountController,
                      textInputType: TextInputType.number,
                      hint: 'Amount',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Amount is required';
                        }
                        return null;
                      }),
                ),
                SizedBox(height: 3.h),
                SizedBox(
                  height: 6.h,
                  child: TextInputFormField(
                      controller: _nameExpenserController,
                      hint: 'Name of Expenser',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name of expenser is required';
                        }
                        return null;
                      }),
                ),
                SizedBox(height: 3.h),
                InkWell(
                  onTap: () => showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2040),
                  ).then((value) {
                    setState(() {
                      selectedDate = value!;
                    });
                  }),
                  child: Container(
                    height: 6.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: StyleResources.secondaryColor),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      selectedDate.toString().split(' ')[0], // Display date
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                SizedBox(
                  height: 6.h,
                  child: TextInputFormField(
                    controller: _remarksController,
                    hint: 'Remarks (optional)',
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 4.h),
                BlocListener<ExpensesBloc, ExpensesState>(
                  listener: (context, state) {
                    state.whenOrNull(
                        expenseCreated: () {
                          getSnackBar(context,
                              title: 'Expense recorded successfully.');
                          Navigator.of(context).pop();
                        },
                        failed: (error) => getSnackBar(context,
                            title: 'Failed to record expense'));
                  },
                  child: BlocBuilder<ExpensesBloc, ExpensesState>(
                    builder: (context, state) {
                      state.whenOrNull(
                        loading: () => LottieBuilder.asset(
                            'assets/loading_animation.json'),
                      );
                      return PrimaryButton(
                        label: 'Submit',
                        ontap: () {
                          if (_formKey.currentState!.validate()) {
                            var expense = FeesPaymentModel(
                                transactionType: FirebaseResources.expense,
                                createdAt: DateTime.now(),
                                paymentDate: selectedDate,
                                expenseName: _nameExpenserController.text,
                                amountSpend:
                                    double.parse(_amountController.text),
                                remarks: _remarksController.text);
                            log('Recording Expense: $expense');
                            context.read<ExpensesBloc>().add(
                                ExpensesEvent.addExpense(
                                    expenseModel: expense));
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
