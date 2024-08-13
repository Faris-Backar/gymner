import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:gym/service/model/members_model.dart';
import 'package:gym/service/repository/members_repository.dart';

part 'members_event.dart';
part 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  final MembersRepository membersRepository;
  late List<MembersModel> membersList;
  MembersBloc({
    required this.membersRepository,
  }) : super(MembersInitial()) {
    on<CreateMembersEvent>(_createMembers);
    on<GetMembersEvent>(_getMembers);
    on<SearchMembersEvent>(_searchMembers);
    on<UploadProfileImageEvent>(_uploadProfileImage);
    on<InitMembersEvent>(_init);
    on<GetIndividualMemberByUidEvent>(_getIndividualMembersbyUid);
  }

  _createMembers(CreateMembersEvent event, Emitter<MembersState> emit) async {
    emit(MembersInitial());
    emit(MembersLoadding());
    try {
      await membersRepository.createMember(membersModel: event.membersModel);
      emit(CreateMembersLoaded());
    } catch (e) {
      emit(MembersFailed(error: e.toString()));
    }
  }

  _getMembers(GetMembersEvent event, Emitter<MembersState> emit) async {
    emit(MembersInitial());
    emit(MembersLoadding());
    try {
      membersList = await membersRepository.getMembers();
      emit(GetMembersLoaded(membersList: membersList));
    } catch (e) {
      log(e.toString());
      emit(MembersFailed(error: e.toString()));
    }
  }

  _searchMembers(SearchMembersEvent event, Emitter<MembersState> emit) async {
    emit(MembersInitial());
    emit(MembersLoadding());
    try {
      final response = membersRepository.searchMembers(
          searchQuery: event.query, membersList: membersList);
      emit(GetMembersLoaded(membersList: response));
    } catch (e) {
      emit(MembersFailed(error: e.toString()));
    }
  }

  _getIndividualMembersbyUid(
      GetIndividualMemberByUidEvent event, Emitter<MembersState> emit) async {
    emit(MembersInitial());
    emit(MembersLoadding());
    try {
      final response =
          await membersRepository.getIndividualMembers(uid: event.uid);
      emit(GetIndividualMembersLoaded(membersModel: response));
    } catch (e) {
      emit(MembersFailed(error: e.toString()));
    }
  }

  _uploadProfileImage(
      UploadProfileImageEvent event, Emitter<MembersState> emit) async {
    emit(MembersInitial());
    try {
      emit(MembersLoadding());
      // Uint8List? file = event.image.readAsBytesSync();
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child("users/${event.uid}.jpg")
          .putFile(event.image);
      emit(UploadImageLoading(taskSnapshot: task.snapshotEvents));
      String imageUrl = '';
      await task.whenComplete(
        () => task.snapshot.ref
            .getDownloadURL()
            .then((value) => imageUrl = value)
            .whenComplete(
              () => emit(
                UploadImageSucess(profilePicUrl: imageUrl),
              ),
            ),
      );

      // snapshot.ref
      //     .getDownloadURL()
      //     .then((value) => imageUrl = value)
      // .whenComplete(() => emit(UploadImageSucess(profilePicUrl: imageUrl)));
    } catch (e) {
      emit(MembersFailed(error: e.toString()));
    }
  }

  _init(InitMembersEvent event, Emitter<MembersState> emit) {
    emit(MembersInitial());
  }
}
