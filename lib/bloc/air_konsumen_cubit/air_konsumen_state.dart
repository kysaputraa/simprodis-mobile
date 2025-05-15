part of 'air_konsumen_cubit.dart';

abstract class AirKonsumenState {}

final class AirKonsumenInitial extends AirKonsumenState {}

final class AirKonsumenLoading extends AirKonsumenState {}

final class AirKonsumenError extends AirKonsumenState {
  String message;
  AirKonsumenError({required this.message});
}

final class AirKonsumenSuccessInsert extends AirKonsumenState {
  String message;
  AirKonsumenSuccessInsert({required this.message});
}
