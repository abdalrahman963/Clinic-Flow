
import 'package:clinic_flow/features/shared/domain/entities/gorvernate.dart';

class GovernateModel extends Governate {
  const GovernateModel({required super.id, required super.name});

  factory GovernateModel.fromJson(Map<String, dynamic> json) {
    return GovernateModel(
      id: (json['id'] is num) ? (json['id'] as num).toInt() : int.tryParse('${json['id']}') ?? 0,
      name: (json['name'] ?? '').toString(), // Correctly points to "name"
    );
  }
}