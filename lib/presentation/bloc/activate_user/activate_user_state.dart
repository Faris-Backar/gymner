part of 'activate_user_bloc.dart';

@freezed
class ActivateUserState with _$ActivateUserState {
  const factory ActivateUserState.initial() = _Initial;
  const factory ActivateUserState.loading() = _Loading;
  const factory ActivateUserState.loaded() = _Loaded;
  const factory ActivateUserState.failed({required String error}) = _Failed;
}
