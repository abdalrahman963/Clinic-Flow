import 'package:clinic_flow/core/utils/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_governates_usecase.dart';
import '../../domain/usecases/get_specializations_usecase.dart';
import 'shared_event.dart';
import 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  final GetGovernatesUseCase getGovernatesUseCase;
  final GetSpecializationsUseCase getSpecializationsUseCase;

  SharedBloc({
    required this.getGovernatesUseCase,
    required this.getSpecializationsUseCase,
  }) : super(const SharedState()) {
    on<FetchGovernatesEvent>(_onFetchGovernates);
    on<FetchSpecializationsEvent>(_onFetchSpecializations);
  }

  Future<void> _onFetchGovernates(FetchGovernatesEvent event, Emitter<SharedState> emit) async {
    // Only update the governates status to loading
    emit(state.copyWith(governatesStatus: SharedStatus.loading));
    
    final result = await getGovernatesUseCase(NoParams());
    
    result.fold(
      (failure) => emit(state.copyWith(
        governatesStatus: SharedStatus.failure,
        errorMessage: failure.message,
      )),
      (governates) => emit(state.copyWith(
        governatesStatus: SharedStatus.success,
        governates: governates,
      )),
    );
  }

  Future<void> _onFetchSpecializations(FetchSpecializationsEvent event, Emitter<SharedState> emit) async {
    // Only update the specializations status to loading
    emit(state.copyWith(specializationsStatus: SharedStatus.loading));
    
    final result = await getSpecializationsUseCase(NoParams());
    
    result.fold(
      (failure) => emit(state.copyWith(
        specializationsStatus: SharedStatus.failure,
        errorMessage: failure.message,
      )),
      (specializations) => emit(state.copyWith(
        specializationsStatus: SharedStatus.success,
        specializations: specializations,
      )),
    );
  }
}