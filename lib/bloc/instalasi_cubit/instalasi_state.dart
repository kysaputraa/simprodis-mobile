part of 'instalasi_cubit.dart';

abstract class InstalasiState {}

final class InstalasiInitial extends InstalasiState {}

final class InstalasiLoading extends InstalasiState {}

final class InstalasiSuccess extends InstalasiState {
  final List<Datum> data;
  final String? selectedInstalasi;
  final String? selectedTanggal;
  final String? selectedJam;
  InstalasiSuccess({
    required this.data,
    this.selectedInstalasi,
    this.selectedTanggal,
    this.selectedJam,
  });
}

final class InstalasiError extends InstalasiState {
  String message;
  InstalasiError({required this.message});
}
