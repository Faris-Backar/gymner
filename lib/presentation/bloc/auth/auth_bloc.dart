import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym/service/model/auth_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_login);
  }
  _login(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthInitial());
      emit(AuthLoading());
      await _auth.signInWithEmailAndPassword(
        email: event.credentials.email!,
        password: event.credentials.password!,
      );
      // prefs.setBool(PrefResources.IS_LOGGED_IN, true);
      emit(AuthSucess());
    } on FirebaseAuthException catch (e) {
      log("firebase exception =>$e");
      emit(
        AuthError(error: e.code),
      );
    }
  }
}
