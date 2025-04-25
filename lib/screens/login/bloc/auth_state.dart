part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  late String token;
  late String username;
  late String code;
  late String message;
  late String id_petugas_hp;
  AuthSuccess({
    required this.token,
    required this.username,
    required this.code,
    required this.message,
    required this.id_petugas_hp,
  });
}

class AuthLogout extends AuthState {}

class AuthError extends AuthState {
  late String message;
  AuthError({required this.message});
}
