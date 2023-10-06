part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthEventLogin extends AuthEvent {
}

class AuthEventLogout extends AuthEvent {}

class AuthEventForgotPassword extends AuthEvent {}

