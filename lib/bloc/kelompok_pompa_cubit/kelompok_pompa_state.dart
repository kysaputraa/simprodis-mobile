part of 'kelompok_pompa_cubit.dart';

@immutable
sealed class KelompokPompaState {}

final class KelompokPompaInitial extends KelompokPompaState {}

final class KelompokPompaLoading extends KelompokPompaState {}

final class KelompokPompaSuccess extends KelompokPompaState {
  final List<DataKelompokPompa>? data;

  final String? message;
  KelompokPompaSuccess({required this.data, this.message});
}

final class KelompokPompaError extends KelompokPompaState {
  String message;
  KelompokPompaError({required this.message});
}
