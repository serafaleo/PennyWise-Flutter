part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final String userId;

  const AuthSuccessState({required this.userId});
}

final class AuthFailureState extends AuthState {
  final String message;

  const AuthFailureState({required this.message});
}
