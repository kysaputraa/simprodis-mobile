part of 'ph_cubit.dart';

abstract class PhState {}

final class PhInitial extends PhState {}

final class PhLoading extends PhState {}

final class PhError extends PhState {
  String message;
  PhError({required this.message});
}

final class PhSuccessInsert extends PhState {
  String message;
  PhSuccessInsert({required this.message});
}
