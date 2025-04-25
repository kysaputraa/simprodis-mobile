part of 'jabatan_bloc.dart';

abstract class JabatanState {}

final class JabatanInitial extends JabatanState {}

final class JabatanLoading extends JabatanState {}

final class JabatanSucces extends JabatanState {
  JabatanModel data;
  JabatanSucces({required this.data});
}

final class JabatanError extends JabatanState {
  String message;
  JabatanError({required this.message});
}
