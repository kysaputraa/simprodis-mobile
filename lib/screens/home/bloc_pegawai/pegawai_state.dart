part of 'pegawai_bloc.dart';

abstract class PegawaiState {}

final class PegawaiInitial extends PegawaiState {}

final class PegawaiLoading extends PegawaiState {}

final class PegawaiSuccess extends PegawaiState {
  PegawaiModel data;
  PegawaiSuccess({required this.data});
}

final class PegawaiError extends PegawaiState {
  String message;
  PegawaiError({required this.message});
}
