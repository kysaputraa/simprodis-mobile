part of 'pompa_padam_cubit.dart';

abstract class PompaPadamState {}

final class PompaPadamInitial extends PompaPadamState {}

final class PompaPadamLoading extends PompaPadamState {}

final class PompaPadamSuccess extends PompaPadamState {
  DataPompaPadam? data;
  String? selectedWaktuPadam;
  String? selectedWaktuHidup;
  PompaPadamSuccess({
    this.data,
    this.selectedWaktuPadam,
    this.selectedWaktuHidup,
  });
}

final class PompaPadamError extends PompaPadamState {
  String message;
  PompaPadamError({required this.message});
}

final class PompaPadamSuccessInsert extends PompaPadamState {
  String message;
  PompaPadamSuccessInsert({required this.message});
}
