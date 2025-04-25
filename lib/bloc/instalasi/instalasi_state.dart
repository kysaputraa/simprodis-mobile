part of 'instalasi_bloc.dart';

abstract class InstalasiState {}

final class InstalasiInitial extends InstalasiState {}

final class InstalasiLoading extends InstalasiState {}

final class InstalasiSucces extends InstalasiState {
  InstalasiModel data;
  InstalasiSucces({required this.data});
}

final class InstalasiError extends InstalasiState {
  String message;
  InstalasiError({required this.message});
}
