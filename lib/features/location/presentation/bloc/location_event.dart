import 'package:clinic_flow/features/location/domain/entities/location.dart';
import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetUserLocationEvent extends LocationEvent {}

class UpdateSelectedLocationEvent extends LocationEvent {
  final Location newLocation;

  const UpdateSelectedLocationEvent({required this.newLocation});

  @override
  List<Object> get props => [newLocation];
}