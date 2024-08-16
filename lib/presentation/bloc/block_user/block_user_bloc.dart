import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:gym/service/repository/members_repository.dart';

part 'block_user_bloc.freezed.dart';
part 'block_user_event.dart';
part 'block_user_state.dart';

class BlockUserBloc extends Bloc<BlockUserEvent, BlockUserState> {
  final MembersRepository membersRepository;
  BlockUserBloc({required this.membersRepository}) : super(const _Initial()) {
    on<BlockUserEvent>(_blockUser);
  }

  _blockUser(BlockUserEvent event, Emitter<BlockUserState> emit) async {
    emit(const BlockUserState.initial());
    try {
      emit(const BlockUserState.loading());
      await event.when(
        blockUser: (uuid, status) =>
            membersRepository.updateIsBlock(isBlocked: status, memberId: uuid),
      );
      emit(const BlockUserState.loaded());
    } catch (e) {
      emit(BlockUserState.failed(error: e.toString()));
    }
  }
}
