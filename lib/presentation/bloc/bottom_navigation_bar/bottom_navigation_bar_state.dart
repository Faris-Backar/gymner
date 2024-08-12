part of 'bottom_navigation_bar_bloc.dart';

@freezed
class BottomNavigationState with _$BottomNavigationState {
  const factory BottomNavigationState({required int currentIndex}) =
      _BottomNavigationState;

  factory BottomNavigationState.initial() {
    return const BottomNavigationState(
      currentIndex: 0,
    );
  }
}
