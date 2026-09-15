import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failures.dart';

// Type is the return type of the use case (e.g., AppLocation)
// Params are the arguments required to call it
abstract class UseCase<Type, Params> {
  // The magic 'call' method makes the class behave like a function
  Future<Either<Failure, Type>> call(Params params);
}

// A simple class to use when a UseCase doesn't need any parameters
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}