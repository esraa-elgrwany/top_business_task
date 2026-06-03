import 'package:test_task/core/errors/exceptions.dart';

class StatusCodeHandler {
  static ServerException handleStatusCode(int? statusCode, dynamic data) {
    final String serverMsg = _extractMessage(data);

    switch (statusCode) {
      case 400:
        return ServerException(message: "Bad Request: $serverMsg", statusCode: statusCode);
      case 401:
        return ServerException(message: "Unauthorized Access: $serverMsg", statusCode: statusCode);
      case 403:
        return ServerException(message: "Access Forbidden: $serverMsg", statusCode: statusCode);
      case 404:
        return ServerException(message: "Resource Not Found: $serverMsg", statusCode: statusCode);
      case 500:
        return ServerException(message: "Internal Server Error: $serverMsg", statusCode: statusCode);
      case 502:
        return ServerException(message: "Bad Gateway: $serverMsg", statusCode: statusCode);
      case 503:
        return ServerException(message: "Service Temporarily Unavailable: $serverMsg", statusCode: statusCode);
      default:
        return ServerException(
          message: "Unexpected Error occurred ($statusCode): $serverMsg",
          statusCode: statusCode,
        );
    }
  }

  static String _extractMessage(dynamic data) {
    if (data == null) return "No details provided by the server.";
    if (data is Map && data.containsKey("message")) {
      return data["message"]?.toString() ?? "Empty message parameter.";
    }
    return data.toString();
  }
}
