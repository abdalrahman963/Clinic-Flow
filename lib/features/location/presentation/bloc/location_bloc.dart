import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_current_location_usecase.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocationUseCase getCurrentLocationUseCase;

  LocationBloc({required this.getCurrentLocationUseCase}) : super(LocationInitial()) {
    on<GetUserLocationEvent>(_onGetUserLocation);
  }

  Future<void> _onGetUserLocation(
    GetUserLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());

    // Because we used the call() method in our UseCase, we can invoke it like a function
    final failureOrLocation = await getCurrentLocationUseCase(NoParams());

    // dartz fold() unwraps the Either: Left is Failure, Right is Success
    failureOrLocation.fold(
      (failure) => emit(LocationError(message: failure.message)),
      (location) => emit(LocationLoaded(location: location)),
    );
  }
}
