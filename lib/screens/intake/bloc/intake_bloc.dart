import 'package:bloc/bloc.dart';

part 'intake_event.dart';
part 'intake_state.dart';

class IntakeBloc extends Bloc<IntakeEvent, IntakeState> {
  IntakeBloc() : super(IntakeInitial()) {
    on<IntakeEventSet>((event, emit) {
      emit(IntakeLoading());
      emit(
        IntakeSuccess(
          idInstalasi: event.id_instalasi,
          namaInstalasi: "",
          tanggal: event.tangal,
          jam: event.jam,
        ),
      );
    });
  }
}
