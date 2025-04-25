part of 'tinggi_sungai_cubit.dart';

abstract class TinggiSungaiState {}

final class TinggiSungaiInitial extends TinggiSungaiState {}

final class TinggiSungaiLoading extends TinggiSungaiState {}

final class TinggiSungaiSuccess extends TinggiSungaiState {
  final List<DataTinggiSungai> data;
  final String? selectedInstalasi;
  final DateTime? selectedTanggal;
  final String? selectedJam;
  final String? message;
  TinggiSungaiSuccess({
    required this.data,
    this.selectedInstalasi,
    this.selectedTanggal,
    this.selectedJam,
    this.message,
  });
}

final class TinggiSungaiError extends TinggiSungaiState {
  String message;
  TinggiSungaiError({required this.message});
}
