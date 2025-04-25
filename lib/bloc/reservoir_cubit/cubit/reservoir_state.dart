part of 'reservoir_cubit.dart';

abstract class ReservoirState {}

final class ReservoirInitial extends ReservoirState {}

final class ReservoirLoading extends ReservoirState {}

final class ReservoirSuccess extends ReservoirState {
  final List<DataReservoir> data;
  final String? selectedInstalasi;
  final DateTime? selectedTanggal;
  final String? selectedJam;
  final String? message;
  ReservoirSuccess({
    required this.data,
    this.selectedInstalasi,
    this.selectedTanggal,
    this.selectedJam,
    this.message,
  });
}

final class ReservoirError extends ReservoirState {
  String message;
  ReservoirError({required this.message});
}

final class ReservoirSuccessInsert extends ReservoirState {}
