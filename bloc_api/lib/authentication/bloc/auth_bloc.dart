import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_api/authentication/methods/google_sign_in.dart';
import 'package:bloc_api/authentication/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial(isLoading: true)) {
    on<AuthEventLogin>((event, emit) async {
      UserCredential cred = await signInWithGoogle();

      if (cred == null) {
        emit(AuthError('Error logging in', isLoading: false));
        return;
      } else {
        MyUser user = MyUser.fromFirebaseUser(cred.user!);
        emit(AuthSuccess(user, isLoading: false));
      }
    });

    on<AuthEventLogout>((event, emit) async {
      try {
        await FirebaseAuth.instance.signOut();
      } catch (e) {
        log(e.toString() as num);
      }

      emit(const AuthInitial(isLoading: false));
    });
  }
}
