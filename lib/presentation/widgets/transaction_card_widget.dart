import 'package:flutter/material.dart';
import 'package:gym/core/resources/firebase_resources.dart';
import 'package:gym/core/resources/functions.dart';
import 'package:gym/service/model/fees_payment_model.dart';
import 'package:gym/service/model/members_model.dart';
import 'package:sizer/sizer.dart';

class TransactionCardWidget extends StatelessWidget {
  const TransactionCardWidget({
    super.key,
    required this.transaction,
    required this.index,
    this.member,
  });

  final FeesPaymentModel transaction;
  final MembersModel? member;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      // shadowColor: Colors.green.withOpacity(.3),
      // surfaceTintColor: Colors.green.withOpacity(.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          children: [
            SizedBox(
              height: 30,
              width: 5,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color:
                        transaction.transactionType == FirebaseResources.income
                            ? Colors.green
                            : Colors.red),
              ),
            ),
            SizedBox(width: 10.w, child: Center(child: Text("${index + 1}"))),
            SizedBox(
                width: 15.w,
                child: Center(
                    child: Text(member?.registerNumber.toString() ??
                        dateFormate(
                            date: transaction.paymentDate ??
                                transaction.createdAt)))),
            SizedBox(
                width: 45.w,
                child: Center(
                    child: Text(transaction.expenseName ??
                        member?.name ??
                        transaction.feesPackage?.name ??
                        ""))),
            SizedBox(
                width: 20.w,
                child: Center(
                    child: Text(transaction.amountpayed?.toStringAsFixed(2) ??
                        transaction.amountSpend?.toStringAsFixed(2) ??
                        "N/A"))),
          ],
        ),
      ),
    );
  }
}
