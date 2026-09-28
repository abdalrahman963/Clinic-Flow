import 'package:equatable/equatable.dart';

import '../../domain/entities/appointment.dart';
import '../../domain/entities/dashboard_stats.dart';

abstract class DoctorDashboardState extends Equatable {
  const DoctorDashboardState();

  @override
  List<Object?> get props => [];
}

class DoctorDashboardInitial extends DoctorDashboardState {
  const DoctorDashboardInitial();
}

class DoctorDashboardLoading extends DoctorDashboardState {
  const DoctorDashboardLoading();
}

class DoctorDashboardLoaded extends DoctorDashboardState {
  const DoctorDashboardLoaded({
    required this.stats,
    required this.appointments,
  });

  final DashboardStats stats;
  final List<Appointment> appointments;

  @override
  List<Object?> get props => [stats, appointments];
}

class DoctorDashboardError extends DoctorDashboardState {
  const DoctorDashboardError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

