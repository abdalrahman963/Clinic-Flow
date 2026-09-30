import 'package:equatable/equatable.dart';

class Specialization extends Equatable {
  final int id;
  final String name;
  final String imagePath; // Local image mapped on the frontend

  const Specialization({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [id, name, imagePath];
}