import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:gym/service/repository/members_repository.dart';

part 'activate_user_bloc.freezed.dart';
part 'activate_user_event.dart';
part 'activate_user_state.dart';

class ActivateUserBloc extends Bloc<ActivateUserEvent, ActivateUserState> {
  final MembersRepository membersRepository;
  ActivateUserBloc({required this.membersRepository})
      : super(const _Initial()) {
    on<ActivateUserEvent>(_activateUser);
  }

  _activateUser(
      ActivateUserEvent event, Emitter<ActivateUserState> emit) async {
    emit(const ActivateUserState.initial());
    try {
      emit(const ActivateUserState.loading());
      await event.when(
          activateUser: (status, uuid) => membersRepository.updateIsActive(
              isActive: status, memberId: uuid));
      emit(const ActivateUserState.loaded());
    } catch (e) {
      emit(ActivateUserState.failed(error: e.toString()));
    }
  }
}
