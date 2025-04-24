class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({
    this.message = 'Failed to communicate with server',
    this.statusCode,
  });

  @override
  String toString() => 'ServerException: $message (Status code: $statusCode)';
}

class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'No internet connection'});
  
  @override
  String toString() => 'NetworkException: $message';
}