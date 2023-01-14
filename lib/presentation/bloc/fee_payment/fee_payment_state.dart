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

  const GetRecentTransactionsSucess({required this.transactionList});
}

class FeePaymentFailed extends FeePaymentState {
  final String error;

  const FeePaymentFailed({required this.error});
}
