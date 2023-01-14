part of 'fee_pending_bloc.dart';

abstract class FeePendingState extends Equatable {
  const FeePendingState();

  @override
  List<Object> get props => [];
}

class FeePendingInitial extends FeePendingState {}

class FeePendingLoading extends FeePendingState {}

class FeePendingLoaded extends FeePendingState {
  final List<MembersModel> pendingMembersList;
  const FeePendingLoaded({
    required this.pendingMembersList,
  });

  @override
  List<Object> get props => [pendingMembersList];
}

class FeePendingFailed extends FeePendingState {
  final String error;
  const FeePendingFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
