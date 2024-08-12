part of 'expiry_report_bloc.dart';

@freezed
class ExpiryReportState with _$ExpiryReportState {
  const factory ExpiryReportState.initial() = _Initial;
  const factory ExpiryReportState.loading() = _Loading;
  const factory ExpiryReportState.loaded(
      {required ExpiryReportModel expiryReport}) = _Loaded;
  const factory ExpiryReportState.failed({required String error}) = _Failed;
}
