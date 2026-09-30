import 'package:equatable/equatable.dart';

abstract class SharedEvent extends Equatable {
  const SharedEvent();

  @override
  List<Object?> get props => [];
}

class FetchGovernatesEvent extends SharedEvent {
  const FetchGovernatesEvent();
}

class FetchSpecializationsEvent extends SharedEvent {
  const FetchSpecializationsEvent();
}