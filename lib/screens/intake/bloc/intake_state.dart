part of 'intake_bloc.dart';

abstract class IntakeState {}

final class IntakeInitial extends IntakeState {}

final class IntakeLoading extends IntakeState {}

final class IntakeSuccess extends IntakeState {
  String idInstalasi, namaInstalasi, tanggal, jam;
  IntakeSuccess({
    required this.idInstalasi,
    required this.namaInstalasi,
    required this.tanggal,
    required this.jam,
  });
}

final class IntakeError extends IntakeState {
  String message;
  IntakeError({required this.message});
}
