abstract class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({String message = 'Server error occurred'})
      : super(message: message);
}

class NetworkFailure extends Failure {
  NetworkFailure({String message = 'Network connection failed'})
      : super(message: message);
}