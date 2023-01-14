// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym/core/resources/pref_resources.dart';

import 'package:gym/service/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth firebase;
  AuthBloc({
    required this.firebase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_login);
  }
  _login(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthInitial());
      emit(AuthLoading());
      final prefs = await SharedPreferences.getInstance();
      await firebase.signInWithEmailAndPassword(
        email: event.credentials.email!,
        password: event.credentials.password!,
      );
      prefs.setBool(PrefResources.IS_LOGGED_IN, true);
      emit(AuthSucess());
    } on FirebaseAuthException catch (e) {
      log("firebase exception =>$e");
      emit(
        AuthError(error: e.code),
      );
    }
  }
}
