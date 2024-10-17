part of 'fee_payment_bloc.dart';

abstract class FeePaymentState extends Equatable {
  const FeePaymentState();

  @override
  List<Object> get props => [];
}

class FeePaymentInitial extends FeePaymentState {}

class FeePaymentLoading extends FeePaymentState {}

class FeePaymentSucess extends FeePaymentState {}

class GetFeePaymentDetailsSucess extends FeePaymentState {
  final List<FeesPaymentModel> feePaymentsList;

  const GetFeePaymentDetailsSucess({required this.feePaymentsList});
}

class GetRecentTransactionsSucess extends FeePaymentState {
  final List<FeesPaymentModel> transactionList;
  final double totalIncome;
  final double totalExpense;
  final List<MembersModel> membersList;

  const GetRecentTransactionsSucess({
    required this.transactionList,
    required this.totalIncome,
    required this.totalExpense,
    required this.membersList,
  });
}

class FeePaymentFailed extends FeePaymentState {
  final String error;

  const FeePaymentFailed({required this.error});
}
