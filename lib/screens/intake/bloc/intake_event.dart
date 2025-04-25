part of 'intake_bloc.dart';

abstract class IntakeEvent {}

class IntakeEventSet extends IntakeEvent {
  final String id_instalasi;
  final String tangal;
  final String jam;

  IntakeEventSet({
    required this.id_instalasi,
    required this.tangal,
    required this.jam,
  });
}
