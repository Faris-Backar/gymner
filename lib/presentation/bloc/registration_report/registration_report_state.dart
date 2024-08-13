part of 'registration_report_bloc.dart';

@freezed
class RegistrationReportState with _$RegistrationReportState {
  const factory RegistrationReportState.initial() = _Initial;
  const factory RegistrationReportState.loading() = _Loading;
  const factory RegistrationReportState.loaded(
      {required RegistrationReportModel registrationReport}) = _Loaded;
  const factory RegistrationReportState.failed({required String error}) =
      _Failed;
}
