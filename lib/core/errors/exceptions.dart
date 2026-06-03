class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  @override
  String toString() => "ServerException [$statusCode]: $message";
}

class LocalCacheException implements Exception {
  final String message;
  LocalCacheException({required this.message});
}

class NetworkTimeoutException implements Exception {
  final String message;
  NetworkTimeoutException({this.message = "Connection timed out. Please check your internet connection."});
}