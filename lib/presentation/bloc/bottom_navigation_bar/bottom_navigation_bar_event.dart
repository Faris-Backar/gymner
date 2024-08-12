part of 'bottom_navigation_bar_bloc.dart';

@freezed
class BottomNavigationEvent with _$BottomNavigationEvent {
  const factory BottomNavigationEvent.pageTapped({required int index}) = PageTapped;
}