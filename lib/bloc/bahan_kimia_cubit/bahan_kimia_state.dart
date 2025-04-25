part of 'bahan_kimia_cubit.dart';

abstract class BahanKimiaState {}

final class BahanKimiaInitial extends BahanKimiaState {}

final class BahanKimiaLoading extends BahanKimiaState {}

// final class BahanKimiaSuccess extends BahanKimiaState {
//   final List<DataBahanKimia> data;
//   final String? selectedInstalasi;
//   final DateTime? selectedTanggal;
//   final String? selectedJam;
//   final String? message;
//   BahanKimiaSuccess({
//     required this.data,
//     this.selectedInstalasi,
//     this.selectedTanggal,
//     this.selectedJam,
//     this.message,
//   });
// }

final class BahanKimiaError extends BahanKimiaState {
  String message;
  BahanKimiaError({required this.message});
}

final class BahanKimiaSuccessInsert extends BahanKimiaState {
  String message;
  BahanKimiaSuccessInsert({required this.message});
}
