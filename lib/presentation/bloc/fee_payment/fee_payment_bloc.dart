import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gym/core/resources/firebase_resources.dart';
import 'package:gym/di/di.dart';
import 'package:gym/presentation/bloc/members/members_bloc.dart';
import 'package:gym/service/model/fees_payment_model.dart';
import 'package:gym/service/model/members_model.dart';

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
      final response = await feesPaymentRepsoitory.getRecentTransactions(
          fromDate: event.fromDate, toDate: event.toDate);
      final totalExpense = _getTotalExpense(transactionList: response);
      final totalIncome = _getTotalIncome(transactionList: response);
      final List<String?> memberUids = response
          .map((transaction) => transaction.memberuid)
          .where((uid) => uid != null)
          .toSet()
          .toList();
      final membersList =
          _filterMembersByUid(getIt<MembersBloc>().membersList, memberUids);
      emit(GetRecentTransactionsSucess(
          transactionList: response,
          totalExpense: totalExpense,
          totalIncome: totalIncome,
          membersList: membersList));
    } catch (e) {
      emit(FeePaymentFailed(error: e.toString()));
    }
  }

  double _getTotalExpense({required List<FeesPaymentModel> transactionList}) {
    final expenseTransactions = transactionList
        .where((transaction) =>
            transaction.transactionType == FirebaseResources.expense &&
            transaction.amountSpend != null)
        .toList();
    final totalExpense = expenseTransactions.fold<double>(
      0.0,
      (sum, transaction) => sum + (transaction.amountSpend ?? 0.0),
    );

    return totalExpense;
  }

  double _getTotalIncome({required List<FeesPaymentModel> transactionList}) {
    final expenseTransactions = transactionList
        .where((transaction) =>
            transaction.transactionType == FirebaseResources.income &&
            transaction.amountpayed != null)
        .toList();
    final totalExpense = expenseTransactions.fold<double>(
      0.0,
      (sum, transaction) => sum + (transaction.amountpayed ?? 0.0),
    );

    return totalExpense;
  }

  List<MembersModel> _filterMembersByUid(
      List<MembersModel> membersList, List<String?> memberUids) {
    return membersList
        .where((member) => memberUids.contains(member.uid))
        .toList();
  }
}
