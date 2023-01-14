import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gym/service/model/members_model.dart';
import 'package:gym/service/repository/fee_payment_repository.dart';

part 'fee_pending_event.dart';
part 'fee_pending_state.dart';

class FeePendingBloc extends Bloc<FeePendingEvent, FeePendingState> {
  final FeesPaymentRepsoitory feesPaymentRepsoitory;
  FeePendingBloc({
    required this.feesPaymentRepsoitory,
  }) : super(FeePendingInitial()) {
    on<GetFeePendingMembersEvent>(_getFeePendingMembers);
  }

  _getFeePendingMembers(
      GetFeePendingMembersEvent event, Emitter<FeePendingState> emit) async {
    emit(FeePendingInitial());
    emit(FeePendingLoading());
    try {
      final response = await feesPaymentRepsoitory.getPendingFeePaymentsByDate(
          dateTime: event.date);
      emit(FeePendingLoaded(pendingMembersList: response));
    } catch (e) {
      emit(FeePendingFailed(error: e.toString()));
    }
  }
}
