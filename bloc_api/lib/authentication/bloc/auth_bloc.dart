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
     MyUser user = MyUser.fromFirebaseUser(cred.user!);

     emit(AuthSuccess(user, isLoading: false));
    });

    on<AuthEventLogout>((event, emit) async {
      await FirebaseAuth.instance.signOut();
      emit(const AuthInitial(isLoading: false));
    });
  }
}
