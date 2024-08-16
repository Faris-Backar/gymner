part of 'activate_user_bloc.dart';

@freezed
class ActivateUserEvent with _$ActivateUserEvent {
  const factory ActivateUserEvent.activateUser(
      {required bool status, required String uuid}) = _ActivateUser;
}
