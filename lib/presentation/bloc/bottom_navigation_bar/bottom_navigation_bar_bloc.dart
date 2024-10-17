// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym/presentation/screens/home_screen.dart';
import 'package:gym/presentation/screens/member_screen.dart';
import 'package:gym/presentation/screens/settings_screen.dart';
import 'package:gym/presentation/screens/transaction_screen.dart';

part 'bottom_navigation_bar_event.dart';
part 'bottom_navigation_bar_state.dart';
part 'bottom_navigation_bar_bloc.freezed.dart';

class BottomNavigationBarBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBarBloc() : super(BottomNavigationState.initial()) {
    on<BottomNavigationEvent>(_onPageTapped);
  }

  List<Widget> tabPages = const [
    HomeScreen(),
    MemberScreen(),
    TransactionScreen(),
    SettingsScreen(),
  ];

  _onPageTapped(
      BottomNavigationEvent event, Emitter<BottomNavigationState> emit) {
    print("ontapped => ${event.index}");
    emit(BottomNavigationState(currentIndex: event.index));
  }
}
