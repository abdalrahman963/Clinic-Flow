import 'package:equatable/equatable.dart';

class Governate extends Equatable {
  final int id;
  final String name;

  const Governate({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}