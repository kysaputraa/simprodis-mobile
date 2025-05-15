part of 'kwh_cubit.dart';

abstract class KwhState {}

final class KwhInitial extends KwhState {}

final class KwhLoading extends KwhState {}

final class KwhSuccess extends KwhState {
  final List<DataKWH> data;
  final String? selectedInstalasi;
  final DateTime? selectedTanggal;
  final String? selectedJam;
  final String? message;
  KwhSuccess({
    required this.data,
    this.selectedInstalasi,
    this.selectedTanggal,
    this.selectedJam,
    this.message,
  });
}

final class KwhSuccessInsert extends KwhState {
  String? message;
  KwhSuccessInsert({this.message});
}

final class KwhError extends KwhState {
  String message;
  KwhError({required this.message});
}
