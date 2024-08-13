import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym/service/model/registration_report_model.dart';
import 'package:gym/service/repository/members_repository.dart';

part 'registration_report_event.dart';
part 'registration_report_state.dart';
part 'registration_report_bloc.freezed.dart';

class RegistrationReportBloc
    extends Bloc<RegistrationReportEvent, RegistrationReportState> {
  final MembersRepository membersRepository;
  RegistrationReportBloc({required this.membersRepository})
      : super(const _Initial()) {
    on<RegistrationReportEvent>(_getRegistrationReport);
  }

  _getRegistrationReport(RegistrationReportEvent event,
      Emitter<RegistrationReportState> emit) async {
    emit(const RegistrationReportState.initial());
    try {
      emit(const RegistrationReportState.loading());
      final totalMembersResponse = await membersRepository.getMembers();
      final totalActiveMembers = totalMembersResponse
          .where((members) => members.isActive == true)
          .toList();
      final totalBlockedMembers = totalMembersResponse
          .where((members) => members.isBlocked == true)
          .toList();
      final totalinActiveMembers = totalMembersResponse
          .where((members) => members.isActive != true)
          .toList();
      final registrationReport = RegistrationReportModel(
          totalMembers: totalActiveMembers.length,
          activeMembers: totalActiveMembers.length,
          inActiveMembers: totalinActiveMembers.length,
          blockedMembers: totalBlockedMembers.length);
      emit(RegistrationReportState.loaded(
          registrationReport: registrationReport));
    } catch (e) {
      emit(RegistrationReportState.failed(error: e.toString()));
    }
  }
}
