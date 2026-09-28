import 'package:equatable/equatable.dart';

class DoctorProfile extends Equatable {
  const DoctorProfile({
    required this.id,
    required this.fullName,
    required this.specialty,
    required this.bio,
    required this.rating,
    required this.consultationFee,
    required this.isVerified,
  });

  final String id;
  final String fullName;
  final String specialty;
  final String bio;
  final double rating;
  final double consultationFee;
  final bool isVerified;

  @override
  List<Object?> get props => [
        id,
        fullName,
        specialty,
        bio,
        rating,
        consultationFee,
        isVerified,
      ];
}

