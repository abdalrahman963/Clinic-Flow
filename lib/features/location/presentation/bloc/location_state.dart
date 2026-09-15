import 'package:clinic_flow/features/location/domain/entities/location.dart';
import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationError extends LocationState {
  final String message;

  const LocationError({required this.message});

  @override
  List<Object> get props => [message];
}

class LocationLoaded extends LocationState {
  final Location selectedLocation; // Only the movable marker remains!

  const LocationLoaded({required this.selectedLocation});

  @override
  List<Object> get props => [selectedLocation];
}