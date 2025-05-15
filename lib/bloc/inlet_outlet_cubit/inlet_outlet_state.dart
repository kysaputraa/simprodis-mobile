part of 'inlet_outlet_cubit.dart';

abstract class InletOutletState {}

final class InletOutletInitial extends InletOutletState {}

final class InletOutletLoading extends InletOutletState {}

final class InletOutletError extends InletOutletState {
  String message;
  InletOutletError({required this.message});
}

final class InletOutletSuccessInsert extends InletOutletState {
  String message;
  InletOutletSuccessInsert({required this.message});
}
