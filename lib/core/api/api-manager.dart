import 'package:dio/dio.dart';
import 'package:test_task/core/api/status_code_handler.dart';
import 'package:test_task/core/utils/constants.dart';
import '../errors/exceptions.dart';

class ApiManager {
  final Dio dio;

  ApiManager({Dio? dioInstance}) : dio = dioInstance ?? Dio() {
    dio.options.baseUrl = Constants.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 15);
    dio.options.headers = {
      "Accept": "application/json",
      "Accept-Language": "en",
    };
  }

  Options _options({Map<String, dynamic>? extraHeaders}) {
    return Options(
      headers: {
        if (extraHeaders != null) ...extraHeaders,
      },
    );
  }

  //get
  Future<Response> getData(
      String endPoint, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? extraHeaders,
      }) async {
    try {
      return await dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: _options(extraHeaders: extraHeaders),
      );
    } on DioException catch (dioError) {
      throw _handleDioError(dioError);
    } catch (e) {
      throw ServerException(message: "An unexpected system crash occurred: $e");
    }
  }

  //post
  Future<Response> postData(
      String endPoint, {
        FormData? body,
        Map<String, dynamic>? extraHeaders,
      }) async {
    try {
      return await dio.post(
        endPoint,
        data: body,
        options: _options(extraHeaders: extraHeaders),
      );
    } catch (e) {
      rethrow;
    }
  }

  Exception _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return NetworkTimeoutException();
    }

    if (error.type == DioExceptionType.connectionError) {
      return NetworkTimeoutException(message: "No reliable network interface available.");
    }

    if (error.type == DioExceptionType.badResponse) {
      return StatusCodeHandler.handleStatusCode(
        error.response?.statusCode,
        error.response?.data,
      );
    }

    return ServerException(message: "Unknown/Untracked HTTP communication pipeline break.");
  }
}

