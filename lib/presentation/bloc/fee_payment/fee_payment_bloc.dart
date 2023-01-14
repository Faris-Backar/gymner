import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gym/service/model/fees_payment_model.dart';

import 'package:gym/service/repository/fee_payment_repository.dart';

part 'fee_payment_event.dart';
part 'fee_payment_state.dart';

class FeePaymentBloc extends Bloc<FeePaymentEvent, FeePaymentState> {
  final FeesPaymentRepsoitory feesPaymentRepsoitory;
  FeePaymentBloc({
    required this.feesPaymentRepsoitory,
  }) : super(FeePaymentInitial()) {
    on<NewFeesPaymentEvent>(_newfeesPayment);
    on<GetFeesPaymentDetailsByIdEvent>(_getFeePaymentDetailsFromId);
    on<GetRecentTransactionsEvent>(_getRecentTransactions);
  }

  _newfeesPayment(
      NewFeesPaymentEvent event, Emitter<FeePaymentState> emit) async {
    emit(FeePaymentInitial());
    emit(FeePaymentLoading());
    try {
      await feesPaymentRepsoitory.newFeePayment(
          feesPaymentModel: event.feesPaymentModel);
      emit(FeePaymentSucess());
    } catch (e) {
      emit(FeePaymentFailed(error: e.toString()));
    }
  }

  _getFeePaymentDetailsFromId(GetFeesPaymentDetailsByIdEvent event,
      Emitter<FeePaymentState> emit) async {
    emit(FeePaymentInitial());
    emit(FeePaymentLoading());
    try {
      final response = await feesPaymentRepsoitory
          .getFeePaymentsDetailsByUserId(memberUid: event.memberUid);
      emit(GetFeePaymentDetailsSucess(feePaymentsList: response));
    } catch (e) {
      emit(FeePaymentFailed(error: e.toString()));
    }
  }

  _getRecentTransactions(
      GetRecentTransactionsEvent event, Emitter<FeePaymentState> emit) async {
    emit(FeePaymentInitial());
    emit(FeePaymentLoading());
    try {
      final response = await feesPaymentRepsoitory.getRecentTransactions();
      emit(GetRecentTransactionsSucess(transactionList: response));
    } catch (e) {
      emit(FeePaymentFailed(error: e.toString()));
    }
  }
}
