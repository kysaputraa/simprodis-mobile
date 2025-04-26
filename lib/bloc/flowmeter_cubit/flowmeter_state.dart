part of 'flowmeter_cubit.dart';

abstract class FlowmeterState {}

final class FlowmeterInitial extends FlowmeterState {}

final class FlowmeterLoading extends FlowmeterState {}

final class FlowmeterSuccess extends FlowmeterState {
  final List<DataFlowmeter> data;

  final String? message;
  FlowmeterSuccess({required this.data, this.message});
}

final class FlowmeterError extends FlowmeterState {
  String message;
  FlowmeterError({required this.message});
}

final class FlowmeterSuccessInsert extends FlowmeterState {}
