import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:gym/service/model/expiry_report_model.dart';
import 'package:gym/service/repository/members_repository.dart';

part 'expiry_report_bloc.freezed.dart';
part 'expiry_report_event.dart';
part 'expiry_report_state.dart';

class ExpiryReportBloc extends Bloc<ExpiryReportEvent, ExpiryReportState> {
  final MembersRepository membersRepository;
  ExpiryReportBloc({required this.membersRepository})
      : super(const _Initial()) {
    on<ExpiryReportEvent>(_getExpriryReport);
  }

  _getExpriryReport(
      ExpiryReportEvent event, Emitter<ExpiryReportState> emit) async {
    emit(const ExpiryReportState.initial());
    try {
      final expiryDataWithIn3days =
          await membersRepository.getMembersExpiringWithin3Days();
      final expiryDataWithIn7days =
          await membersRepository.getMembersExpiringWithin7Days();
      final expiryDataWithIn30days =
          await membersRepository.getMembersExpiringWithin30Days();
      final ExpiryReportModel expiryReportModel = ExpiryReportModel(
          expiryWithinOneToThreeDays: expiryDataWithIn3days.length,
          expiryWithinFourToSevenDays: expiryDataWithIn7days.length,
          expiryWithinSeventoThirtyDays: expiryDataWithIn30days.length,
          expiredActiveMembers: 0);
      emit(const ExpiryReportState.loading());
      emit(ExpiryReportState.loaded(expiryReport: expiryReportModel));
    } catch (e) {
      emit(ExpiryReportState.failed(error: e.toString()));
    }
  }
}
