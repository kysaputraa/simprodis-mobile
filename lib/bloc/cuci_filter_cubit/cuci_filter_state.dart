part of 'cuci_filter_cubit.dart';

abstract class CuciFilterState {}

final class CuciFilterInitial extends CuciFilterState {}

final class CuciFilterLoading extends CuciFilterState {}

final class CuciFilterSuccess extends CuciFilterState {
  final List<int> data;
  final List<String> selectedItems;
  final String? message;
  CuciFilterSuccess({
    required this.data,
    this.message,
    this.selectedItems = const [],
  });
}

final class CuciFilterError extends CuciFilterState {
  String message;
  CuciFilterError({required this.message});
}

final class CuciFilterSuccessInsert extends CuciFilterState {
  String message;
  CuciFilterSuccessInsert({required this.message});
}
