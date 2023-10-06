part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  final String? loadingText;
  final bool isLoading;
  const AuthState(
      {this.loadingText = "Please wait...", required this.isLoading});
}

final class AuthInitial extends AuthState {
  const AuthInitial({required bool isLoading}) : super(isLoading: isLoading);
}

final class AuthError extends AuthState {
  final String message;

  const AuthError(this.message, {required super.isLoading});
}

final class AuthSuccess extends AuthState {
  final MyUser user;

  const AuthSuccess(this.user, {required super.isLoading});
}
