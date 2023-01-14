part of 'members_bloc.dart';

abstract class MembersState extends Equatable {
  const MembersState();

  @override
  List<Object> get props => [];
}

class MembersInitial extends MembersState {}

class MembersLoadding extends MembersState {}

class GetMembersLoaded extends MembersState {
  final List<MembersModel> membersList;
  const GetMembersLoaded({
    required this.membersList,
  });
  @override
  List<Object> get props => [membersList];
}

class CreateMembersLoaded extends MembersState {}

class GetIndividualMembersLoaded extends MembersState {
  final MembersModel membersModel;
  const GetIndividualMembersLoaded({
    required this.membersModel,
  });

  @override
  List<Object> get props => [membersModel];
}

class MembersFailed extends MembersState {
  final String error;
  const MembersFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class UploadImageSucess extends MembersState {
  final String profilePicUrl;
  const UploadImageSucess({
    required this.profilePicUrl,
  });
}

class UploadImageLoading extends MembersState {
  final Stream<TaskSnapshot> taskSnapshot;
  const UploadImageLoading({
    required this.taskSnapshot,
  });
}
