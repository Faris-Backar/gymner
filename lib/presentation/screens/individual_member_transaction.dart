import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/core/resources/style_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/presentation/bloc/fee_payment/fee_payment_bloc.dart';
import 'package:gym/presentation/widgets/header_text.dart';
import 'package:gym/presentation/widgets/transaction_card_widget.dart';
import 'package:sizer/sizer.dart';

class IndividualMemberTransaction extends StatelessWidget {
  final String memberUuid;
  const IndividualMemberTransaction({super.key, required this.memberUuid});

  @override
  Widget build(BuildContext context) {
    final feePaymentBloc = getIt<FeePaymentBloc>();
    feePaymentBloc.add(GetFeesPaymentDetailsByIdEvent(memberUid: memberUuid));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: StyleResources.black,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10.w, child: const HeaderText("Sl.No")),
                  SizedBox(
                      width: 25.w, child: const HeaderText("Date of Payment")),
                  SizedBox(
                      width: 35.w,
                      child: const Center(child: HeaderText("Package"))),
                  SizedBox(width: 20.w, child: const HeaderText("Amount")),
                ],
              ),
            )),
      ),
      body: BlocBuilder<FeePaymentBloc, FeePaymentState>(
        builder: (context, state) {
          if (state is GetFeePaymentDetailsSucess) {
            return ListView.builder(
              itemCount: state.feePaymentsList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TransactionCardWidget(
                    transaction: state.feePaymentsList[index], index: index),
              ),
            );
          }
          if (state is FeePaymentLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor:
                    AlwaysStoppedAnimation<Color>(StyleResources.primaryColor),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
