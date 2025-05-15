part of 'air_lengkap_cubit.dart';

abstract class AirLengkapState {}

final class AirLengkapInitial extends AirLengkapState {}

final class AirLengkapLoading extends AirLengkapState {}

final class AirLengkapError extends AirLengkapState {
  String message;
  AirLengkapError({required this.message});
}

final class AirLengkapSuccessInsert extends AirLengkapState {
  String message;
  AirLengkapSuccessInsert({required this.message});
}
