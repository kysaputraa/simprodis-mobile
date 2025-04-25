part of 'pressure_cubit.dart';

abstract class PressureState {}

final class PressureInitial extends PressureState {}

final class PressureLoading extends PressureState {}

final class PressureSuccess extends PressureState {
  final List<DataPressureGabungan> data;
  final String? selectedInstalasi;
  final DateTime? selectedTanggal;
  final String? selectedJam;
  final String? message;
  PressureSuccess({
    required this.data,
    this.selectedInstalasi,
    this.selectedTanggal,
    this.selectedJam,
    this.message,
  });
}

final class PressureError extends PressureState {
  String message;
  PressureError({required this.message});
}

final class PressureSuccessInsert extends PressureState {}
