import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  const Appointment({
    required this.id,
    required this.patientName,
    required this.startIso,
    required this.endIso,
    required this.mode,
    required this.status,
  });

  final String id;
  final String patientName;
  final String startIso;
  final String endIso;
  final AppointmentMode mode;
  final AppointmentStatus status;

  @override
  List<Object?> get props => [id, patientName, startIso, endIso, mode, status];
}

enum AppointmentMode { inPerson, video }

enum AppointmentStatus { pending, accepted, rejected, arrived, inSession, completed, cancelled }

