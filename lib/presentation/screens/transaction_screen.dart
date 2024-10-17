import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/core/utils/pdf/pdf_generation.dart';
import 'package:gym/presentation/bloc/fee_payment/fee_payment_bloc.dart';
import 'package:gym/presentation/widgets/date_selector_widget.dart';
import 'package:gym/presentation/widgets/header_text.dart';
import 'package:gym/presentation/widgets/primary_button.dart';
import 'package:gym/presentation/widgets/summary_row.dart';
import 'package:gym/presentation/widgets/transaction_card_widget.dart';
import 'package:gym/service/model/fees_payment_model.dart';
import 'package:gym/service/model/members_model.dart';
import 'package:gym/service/model/package_model.dart';
import 'package:sizer/sizer.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        actions: [
          BlocBuilder<FeePaymentBloc, FeePaymentState>(
            builder: (context, state) {
              if (state is GetRecentTransactionsSucess) {
                return IconButton(
                  onPressed: () {
                    try {
                      generateTransactionPdf(
                          state.transactionList, state.membersList);
                    } catch (e) {
                      log("Pdf Generation error => $e");
                    }
                  },
                  icon: const Icon(Icons.picture_as_pdf_rounded),
                );
              }
              return IconButton(
                onPressed: () {},
                icon: const Icon(Icons.picture_as_pdf_rounded),
                color: Colors.grey,
              );
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 170),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildDateSelectors(),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PrimaryButton(
                    label: "Get Transactions",
                    backgroundColor: StyleResources.primaryColor,
                    ontap: _fetchTransactions,
                  ),
                ),
                const SizedBox(height: 10),
                _buildTransactionHeader(),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: BlocBuilder<FeePaymentBloc, FeePaymentState>(
          builder: (context, state) {
            if (state is FeePaymentLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is GetRecentTransactionsSucess) {
              return _buildTransactionList(
                  state.transactionList, state.membersList);
            }
            if (state is FeePaymentFailed) {
              return Center(child: Text(state.error));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<FeePaymentBloc, FeePaymentState>(
          builder: (context, state) {
        if (state is GetRecentTransactionsSucess) {
          return _buildSummary(
              totalExpense: state.totalExpense, totalIncome: state.totalIncome);
        }
        return const SizedBox.shrink();
      }),
    );
  }

  // Extracted widget methods for better code structure
  Widget _buildDateSelectors() {
    return Row(
      children: [
        Expanded(
          child: DateSelector(
            selectedDate: startDate,
            onDateSelected: (date) => setState(() => startDate = date),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DateSelector(
            selectedDate: endDate,
            onDateSelected: (date) => setState(() => endDate = date),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionHeader() {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10.w, child: const HeaderText("Sl.No")),
          SizedBox(width: 15.w, child: const HeaderText("Ad.No")),
          SizedBox(width: 45.w, child: const Center(child: HeaderText("Name"))),
          SizedBox(width: 20.w, child: const HeaderText("Amount")),
        ],
      ),
    );
  }

  Widget _buildTransactionList(
      List<FeesPaymentModel> transactions, List<MembersModel> membersModel) {
    if (transactions.isEmpty) {
      return const Center(
          child: Text("No Data is Available for this date range"));
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        // Find the corresponding member model using memberUid
        final member = membersModel.firstWhere(
          (member) => member.uid == transaction.memberuid,
          orElse: () => MembersModel(
            uid: transaction.memberuid ?? "",
            name: "Unknown", // You can customize this default value,
            registerNumber: 0,
            mobileNumber: 0,
            packageModel: PackageModel(name: "", price: 0, uid: ""),
          ),
        );
        return TransactionCardWidget(
          transaction: transaction,
          member: member,
          index: index,
        );
      },
    );
  }

  Widget _buildSummary(
      {required double totalIncome, required double totalExpense}) {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          SummaryRow(label: "Total Income", value: "\u{20B9} $totalIncome"),
          SummaryRow(label: "Total Expense", value: "\u{20B9} $totalExpense"),
        ],
      ),
    );
  }

  void _fetchTransactions() {
    context
        .read<FeePaymentBloc>()
        .add(GetRecentTransactionsEvent(fromDate: startDate, toDate: endDate));
  }
}
