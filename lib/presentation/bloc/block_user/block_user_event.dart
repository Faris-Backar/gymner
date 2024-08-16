part of 'block_user_bloc.dart';

@freezed
class BlockUserEvent with _$BlockUserEvent {
  const factory BlockUserEvent.blockUser(
      {required String uuid, required bool status}) = _BlockUser;
}
