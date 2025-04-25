part of 'stand_meter_cubit.dart';

abstract class StandMeterState {}

final class StandMeterInitial extends StandMeterState {}

final class StandMeterLoading extends StandMeterState {}

final class StandMeterSuccess extends StandMeterState {
  final List<DataStandMeter> data;
  final String? selectedInstalasi;
  final DateTime? selectedTanggal;
  final String? selectedJam;
  final String? message;
  StandMeterSuccess({
    required this.data,
    this.selectedInstalasi,
    this.selectedTanggal,
    this.selectedJam,
    this.message,
  });
}

final class StandMeterError extends StandMeterState {
  String message;
  StandMeterError({required this.message});
}

final class StandMeterSuccessInsert extends StandMeterState {}
