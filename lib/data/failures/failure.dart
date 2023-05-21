import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure(message) : super(message: message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(message) : super(message: message);

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure(message) : super(message: message);

  @override
  List<Object> get props => [message];
}
