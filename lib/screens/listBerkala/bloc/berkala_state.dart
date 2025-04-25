part of 'berkala_bloc.dart';

abstract class BerkalaState {}

final class BerkalaInitial extends BerkalaState {}

final class BerkalaLoading extends BerkalaState {}

final class BerkalaSucces extends BerkalaState {
  BerkalaModel data;
  BerkalaSucces({required this.data});
}

final class BerkalaError extends BerkalaState {
  String message;
  BerkalaError({required this.message});
}
