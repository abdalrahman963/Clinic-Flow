import '../../domain/entities/doctor_profile.dart';

class DoctorProfileModel extends DoctorProfile {
  const DoctorProfileModel({
    required super.id,
    required super.fullName,
    required super.specialty,
    required super.bio,
    required super.rating,
    required super.consultationFee,
    required super.isVerified,
  });

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
      id: (json['id'] ?? '').toString(),
      fullName: (json['fullName'] ?? json['name'] ?? 'Doctor').toString(),
      specialty: (json['specialty'] ?? 'General').toString(),
      bio: (json['bio'] ?? '').toString(),
      rating: (json['rating'] is num) ? (json['rating'] as num).toDouble() : 4.8,
      consultationFee:
          (json['consultationFee'] is num) ? (json['consultationFee'] as num).toDouble() : 120,
      isVerified: json['isVerified'] == true,
    );
  }
}

