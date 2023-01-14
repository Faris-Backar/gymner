part of 'fee_pending_bloc.dart';

abstract class FeePendingEvent extends Equatable {
  const FeePendingEvent();

  @override
  List<Object> get props => [];
}

class GetFeePendingMembersEvent extends FeePendingEvent {
  final DateTime date;
  const GetFeePendingMembersEvent({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}
