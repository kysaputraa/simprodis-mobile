part of 'spey_clarif_cubit.dart';

abstract class SpeyClarifState {}

final class SpeyClarifInitial extends SpeyClarifState {}

final class SpeyClarifLoading extends SpeyClarifState {}

final class SpeyClarifError extends SpeyClarifState {
  String message;
  SpeyClarifError({required this.message});
}

final class SpeyClarifSuccessInsert extends SpeyClarifState {
  String message;
  SpeyClarifSuccessInsert({required this.message});
}
