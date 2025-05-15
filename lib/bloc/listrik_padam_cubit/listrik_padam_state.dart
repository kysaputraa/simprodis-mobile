part of 'listrik_padam_cubit.dart';

abstract class ListrikPadamState {}

final class ListrikPadamInitial extends ListrikPadamState {}

final class ListrikPadamLoading extends ListrikPadamState {}

final class ListrikPadamSuccess extends ListrikPadamState {
  DataListrikPadam? data;
  String? selectedWaktuPadam;
  String? selectedWaktuHidup;
  ListrikPadamSuccess({
    this.data,
    this.selectedWaktuPadam,
    this.selectedWaktuHidup,
  });
}

final class ListrikPadamError extends ListrikPadamState {
  String message;
  ListrikPadamError({required this.message});
}

final class ListrikPadamSuccessInsert extends ListrikPadamState {
  String message;
  ListrikPadamSuccessInsert({required this.message});
}
