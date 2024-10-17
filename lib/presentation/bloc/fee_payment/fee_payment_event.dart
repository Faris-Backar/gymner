part of 'fee_payment_bloc.dart';

abstract class FeePaymentEvent extends Equatable {
  const FeePaymentEvent();

  @override
  List<Object> get props => [];
}

class NewFeesPaymentEvent extends FeePaymentEvent {
  final FeesPaymentModel feesPaymentModel;
  const NewFeesPaymentEvent({
    required this.feesPaymentModel,
  });
  @override
  List<Object> get props => [feesPaymentModel];
}

class GetFeesPaymentDetailsByIdEvent extends FeePaymentEvent {
  final String memberUid;
  const GetFeesPaymentDetailsByIdEvent({
    required this.memberUid,
  });
  @override
  List<Object> get props => [memberUid];
}

class GetRecentTransactionsEvent extends FeePaymentEvent {
  final DateTime fromDate;
  final DateTime toDate;

  const GetRecentTransactionsEvent(
      {required this.fromDate, required this.toDate});
}
