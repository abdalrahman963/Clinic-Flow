  import 'package:geolocator/geolocator.dart';
import '../models/location_model.dart';

abstract class LocationRemoteDataSource {
  Future<LocationModel> getCurrentPosition();
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  @override
  Future<LocationModel> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LocationModel(
      latitude: position.latitude, 
      longitude: position.longitude
    );
  }
}