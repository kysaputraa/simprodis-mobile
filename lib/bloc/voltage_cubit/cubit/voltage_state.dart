part of 'voltage_cubit.dart';

abstract class VoltageState {}

final class VoltageInitial extends VoltageState {}

final class VoltageLoading extends VoltageState {}

final class VoltageSuccess extends VoltageState {
  final List<DataVoltage> data;
  final String? selectedInstalasi;
  final DateTime? selectedTanggal;
  final String? selectedJam;
  final String? message;
  VoltageSuccess({
    required this.data,
    this.selectedInstalasi,
    this.selectedTanggal,
    this.selectedJam,
    this.message,
  });
}

final class VoltageError extends VoltageState {
  String message;
  VoltageError({required this.message});
}

final class VoltageSuccessInsert extends VoltageState {
  String message;
  VoltageSuccessInsert({required this.message});
}
