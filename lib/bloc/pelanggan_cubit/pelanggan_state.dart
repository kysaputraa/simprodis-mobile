part of 'pelanggan_cubit.dart';

abstract class PelangganState {}

final class PelangganInitial extends PelangganState {}

final class PelangganLoading extends PelangganState {}

final class PelangganError extends PelangganState {
  String message;
  PelangganError({required this.message});
}

final class PelangganSuccess extends PelangganState {
  String? message;
  DataPelanggan? dataPelanggan;
  PelangganSuccess({this.message, required this.dataPelanggan});
}
