part of 'buku_saku_bloc.dart';

abstract class BukuSakuState {}

final class BukuSakuInitial extends BukuSakuState {}

final class BukuSakuLoading extends BukuSakuState {}

final class BukuSakuSuccess extends BukuSakuState {
  SkDireksiModel data;
  BukuSakuSuccess({required this.data});
}

final class BukuSakuError extends BukuSakuState {
  String message;
  BukuSakuError({required this.message});
}
