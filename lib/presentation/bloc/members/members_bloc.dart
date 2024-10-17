import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gym/core/constants/dashboard_constants.dart';

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
    on<GetMembersByFilterEvent>(_getMembersByFilterValue);
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

  _getMembersByFilterValue(
      GetMembersByFilterEvent event, Emitter<MembersState> emit) async {
    emit(MembersInitial());
    emit(MembersLoadding());

    try {
      List<MembersModel> filteredMemberList = [];

      // Apply filter logic
      filteredMemberList = filterMembers(
        membersList: membersList,
        statusFilter: event.filterActiveType?.toLowerCase() ??
            DashboardConstants.all, // Active, Inactive, or All
        packageExpireFilter: event.filterByPackageExpiry?.toLowerCase() ??
            DashboardConstants.upcomingExpiryReport[0], // Expiry filter
        packageNameFilter: event.filterByPackageType ?? 'All', // Package filter
      );

      // Emit the filtered list
      emit(GetMembersLoaded(membersList: filteredMemberList));
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

  List<MembersModel> filterMembers({
    required List<MembersModel> membersList,
    String statusFilter = 'All',
    String packageExpireFilter = 'All',
    String packageNameFilter = 'All',
  }) {
    final now = DateTime.now();

    return membersList.where((member) {
      // Filter by active/inactive status
      if (statusFilter != 'All') {
        if (statusFilter == 'active' && !(member.isActive ?? false)) {
          return false;
        }
        if (statusFilter == 'inactive' && (member.isActive ?? true)) {
          return false;
        }
      }

      // Filter by package expiration
      if (packageExpireFilter != 'All') {
        if (member.packageEndDate == null) return false;
        final daysLeft = member.packageEndDate!.difference(now).inDays;
        log("Expiry Days = $daysLeft /n package endDate => ${member.packageEndDate}");
        switch (packageExpireFilter) {
          case '1-3 days':
            if (daysLeft < 1 || daysLeft > 3) return false;
            break;
          case '4-7 days':
            if (daysLeft < 4 || daysLeft > 7) return false;
            break;
          case '2 weeks':
            if (daysLeft < 8 || daysLeft > 14) return false;
            break;
          case 'expired':
            if (daysLeft > 0) return false;
            break;
          default:
            break;
        }
      }

      // Filter by package name
      if (packageNameFilter != 'All' &&
          member.packageModel.name != packageNameFilter) {
        return false;
      }

      return true;
    }).toList();
  }
}
