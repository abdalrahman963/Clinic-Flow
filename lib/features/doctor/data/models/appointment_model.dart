import '../../domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  const AppointmentModel({
    required super.id,
    required super.patientName,
    required super.startIso,
    required super.endIso,
    required super.mode,
    required super.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: (json['id'] ?? '').toString(),
      patientName: (json['patientName'] ?? json['patient'] ?? 'Patient').toString(),
      startIso: (json['startIso'] ?? json['start'] ?? '').toString(),
      endIso: (json['endIso'] ?? json['end'] ?? '').toString(),
      mode: _parseMode((json['mode'] ?? '').toString()),
      status: _parseStatus((json['status'] ?? '').toString()),
    );
  }
}

AppointmentMode _parseMode(String raw) {
  switch (raw.toLowerCase()) {
    case 'video':
      return AppointmentMode.video;
    case 'in_person':
    case 'inperson':
    case 'clinic':
      return AppointmentMode.inPerson;
    default:
      return AppointmentMode.inPerson;
  }
}

AppointmentStatus _parseStatus(String raw) {
  switch (raw.toLowerCase()) {
    case 'accepted':
      return AppointmentStatus.accepted;
    case 'rejected':
      return AppointmentStatus.rejected;
    case 'arrived':
      return AppointmentStatus.arrived;
    case 'in_session':
    case 'insession':
      return AppointmentStatus.inSession;
    case 'completed':
      return AppointmentStatus.completed;
    case 'cancelled':
    case 'canceled':
      return AppointmentStatus.cancelled;
    case 'pending':
    default:
      return AppointmentStatus.pending;
  }
}

