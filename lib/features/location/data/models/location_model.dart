import 'package:clinic_flow/features/location/domain/entities/location.dart';



class LocationModel extends Location {
  LocationModel({
    required super.latitude,
    required super.longitude,
  });

  // If you ever need to save locations to local storage or fetch from an API,
  // you would add fromJson and toJson methods here.
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}