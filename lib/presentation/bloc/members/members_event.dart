// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'members_bloc.dart';

abstract class MembersEvent extends Equatable {
  const MembersEvent();

  @override
  List<Object> get props => [];
}

class CreateMembersEvent extends MembersEvent {
  final MembersModel membersModel;
  const CreateMembersEvent({
    required this.membersModel,
  });
  @override
  List<Object> get props => [membersModel];
}

class GetMembersEvent extends MembersEvent {}

class GetIndividualMemberEvent extends MembersEvent {
  final String regNumber;
  const GetIndividualMemberEvent({
    required this.regNumber,
  });
  @override
  List<Object> get props => [regNumber];
}

class SearchMembersEvent extends MembersEvent {
  final String query;
  const SearchMembersEvent({
    required this.query,
  });
  @override
  List<Object> get props => [query];
}

class UploadProfileImageEvent extends MembersEvent {
  final File image;
  const UploadProfileImageEvent({
    required this.image,
  });
}

class InitMembersEvent extends MembersEvent {}
