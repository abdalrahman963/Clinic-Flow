import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_doctor_dashboard_usecase.dart';
import '../../domain/usecases/get_today_appointments_usecase.dart';
import 'doctor_dashboard_event.dart';
import 'doctor_dashboard_state.dart';

class DoctorDashboardBloc extends Bloc<DoctorDashboardEvent, DoctorDashboardState> {
  DoctorDashboardBloc({
    required this.getDoctorDashboardUseCase,
    required this.getTodayAppointmentsUseCase,
  }) : super(const DoctorDashboardInitial()) {
    on<LoadDoctorDashboardEvent>(_onLoad);
  }

  final GetDoctorDashboardUseCase getDoctorDashboardUseCase;
  final GetTodayAppointmentsUseCase getTodayAppointmentsUseCase;

  Future<void> _onLoad(
    LoadDoctorDashboardEvent event,
    Emitter<DoctorDashboardState> emit,
  ) async {
    emit(const DoctorDashboardLoading());

    final statsResult = await getDoctorDashboardUseCase(NoParams());
    final apptResult = await getTodayAppointmentsUseCase(NoParams());

    final failure = statsResult.fold((l) => l, (_) => null) ?? apptResult.fold((l) => l, (_) => null);
    if (failure != null) {
      emit(DoctorDashboardError(failure.message));
      return;
    }

    final stats = statsResult.getOrElse(() => throw StateError('Expected stats'));
    final appts = apptResult.getOrElse(() => throw StateError('Expected appointments'));
    emit(DoctorDashboardLoaded(stats: stats, appointments: appts));
  }
}

