part of 'spey_clarif_cubit.dart';

abstract class SpeyClarifState {}

final class SpeyClarifInitial extends SpeyClarifState {}

final class SpeyClarifLoading extends SpeyClarifState {}

final class SpeyClarifSuccess extends SpeyClarifState {
  final List<int> data;
  final List<String> selectedItems;
  final String? message;
  SpeyClarifSuccess({
    required this.data,
    this.message,
    this.selectedItems = const [],
  });
}

final class SpeyClarifError extends SpeyClarifState {
  String message;
  SpeyClarifError({required this.message});
}

final class SpeyClarifSuccessInsert extends SpeyClarifState {
  String message;
  SpeyClarifSuccessInsert({required this.message});
}
