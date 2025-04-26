part of 'scada_cubit.dart';

abstract class ScadaState {}

final class ScadaInitial extends ScadaState {}

final class ScadaLoading extends ScadaState {}

final class ScadaError extends ScadaState {
  String message;
  ScadaError({required this.message});
}

final class ScadaSuccessInsert extends ScadaState {
  String message;
  ScadaSuccessInsert({required this.message});
}
