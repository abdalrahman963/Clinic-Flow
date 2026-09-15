import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_current_location_usecase.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocationUseCase getCurrentLocationUseCase;

  LocationBloc({required this.getCurrentLocationUseCase}) : super(LocationInitial()) {
    on<GetUserLocationEvent>(_onGetUserLocation);
    on<UpdateSelectedLocationEvent>(_onUpdateSelectedLocation);
  }

  Future<void> _onGetUserLocation(GetUserLocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoading());

    final failureOrLocation = await getCurrentLocationUseCase(NoParams());

    failureOrLocation.fold(
      (failure) => emit(LocationError(message: failure.message)),
      (location) => emit(LocationLoaded(selectedLocation: location)),
    );
  }

  void _onUpdateSelectedLocation(UpdateSelectedLocationEvent event, Emitter<LocationState> emit) {
    emit(LocationLoaded(selectedLocation: event.newLocation));
  }
}