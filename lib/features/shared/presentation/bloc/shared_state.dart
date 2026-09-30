import 'package:clinic_flow/features/shared/domain/entities/gorvernate.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/specialization.dart';

enum SharedStatus { initial, loading, success, failure }

class SharedState extends Equatable {
  final SharedStatus governatesStatus;
  final SharedStatus specializationsStatus;
  
  final List<Governate> governates;
  final List<Specialization> specializations;
  
  final String? errorMessage;

  const SharedState({
    this.governatesStatus = SharedStatus.initial,
    this.specializationsStatus = SharedStatus.initial,
    this.governates = const [],
    this.specializations = const [],
    this.errorMessage,
  });

  // The copyWith method lets us update just ONE part of the state without losing the rest
  SharedState copyWith({
    SharedStatus? governatesStatus,
    SharedStatus? specializationsStatus,
    List<Governate>? governates,
    List<Specialization>? specializations,
    String? errorMessage,
  }) {
    return SharedState(
      governatesStatus: governatesStatus ?? this.governatesStatus,
      specializationsStatus: specializationsStatus ?? this.specializationsStatus,
      governates: governates ?? this.governates,
      specializations: specializations ?? this.specializations,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        governatesStatus,
        specializationsStatus,
        governates,
        specializations,
        errorMessage,
      ];
}