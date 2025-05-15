part of 'air_harian_cubit.dart';

abstract class AirHarianState {}

final class AirHarianInitial extends AirHarianState {}

final class AirHarianLoading extends AirHarianState {}

final class AirHarianError extends AirHarianState {
  String message;
  AirHarianError({required this.message});
}

final class AirHarianSuccessInsert extends AirHarianState {
  String message;
  AirHarianSuccessInsert({required this.message});
}
