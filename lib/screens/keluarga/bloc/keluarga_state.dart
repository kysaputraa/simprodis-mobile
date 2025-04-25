part of 'keluarga_bloc.dart';

abstract class KeluargaState {}

final class KeluargaInitial extends KeluargaState {}

final class KeluargaLoading extends KeluargaState {}

final class KeluargaSucces extends KeluargaState {
  KeluargaModel data;
  KeluargaSucces({required this.data});
}

final class KeluargaError extends KeluargaState {
  String message;
  KeluargaError({required this.message});
}
