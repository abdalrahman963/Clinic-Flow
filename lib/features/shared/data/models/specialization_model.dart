import '../../domain/entities/specialization.dart';

class SpecializationModel extends Specialization {
  const SpecializationModel({
    required super.id,
    required super.name,
    required super.imagePath,
  });

  factory SpecializationModel.fromJson(Map<String, dynamic> json) {
    final name = (json['name'] ?? '').toString();
    
    return SpecializationModel(
      id: (json['id'] is num) ? (json['id'] as num).toInt() : int.tryParse('${json['id']}') ?? 0,
      name: name,
      imagePath: _mapImageToSpecialization(name),
    );
  }
}

// Highly precise mapping based on the 7 API specializations
String _mapImageToSpecialization(String name) {
  final normalized = name.toLowerCase();
  
  if (normalized.contains('cardiology')) return 'assets/images/cardiology.png';
  if (normalized.contains('dentistry')) return 'assets/images/dentistry.png';
  if (normalized.contains('dermatology')) return 'assets/images/dermatology.png';
  if (normalized.contains('neurology')) return 'assets/images/neurology.png';
  if (normalized.contains('ophthalmology')) return 'assets/images/ophthalmology.png';
  if (normalized.contains('orthopedics')) return 'assets/images/orthopedics.png';
  if (normalized.contains('pediatrics')) return 'assets/images/pediatrics.png';

  // Fallback just in case the backend adds a new specialization later
  return 'assets/images/general_medicine.png'; 
}