part of 'pompa_cubit.dart';

abstract class PompaState {}

final class PompaInitial extends PompaState {}

final class PompaLoading extends PompaState {}

final class PompaSuccess extends PompaState {
  final List<DataPompa> data;
  final String? selectedInstalasi;
  final DateTime? selectedTanggal;
  final String? selectedJam;
  final String? message;
  PompaSuccess({
    required this.data,
    this.selectedInstalasi,
    this.selectedTanggal,
    this.selectedJam,
    this.message,
  });
}

final class PompaSuccessInsert extends PompaState {}

final class PompaError extends PompaState {
  String message;
  PompaError({required this.message});
}
