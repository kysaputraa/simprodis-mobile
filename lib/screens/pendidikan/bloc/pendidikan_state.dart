part of 'pendidikan_bloc.dart';

abstract class PendidikanState {}

final class PendidikanInitial extends PendidikanState {}

final class PendidikanLoading extends PendidikanState {}

final class PendidikanSucces extends PendidikanState {
  PendidikanModel data;
  PendidikanSucces({required this.data});
}

final class PendidikanError extends PendidikanState {
  String message;
  PendidikanError({required this.message});
}
