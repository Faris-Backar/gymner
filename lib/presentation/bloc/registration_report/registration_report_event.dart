part of 'registration_report_bloc.dart';

@freezed
class RegistrationReportEvent with _$RegistrationReportEvent {
  const factory RegistrationReportEvent.getRegistrationReport() = _Started;
}
