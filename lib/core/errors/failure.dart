import 'package:dio/dio.dart';

// Abstract class representing a failure during API calls
abstract class Failure {
  final String errMessage;

  Failure(this.errMessage);
}

// Concrete subclass of Failure for server-related errors
class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  // Factory method to create a ServerFailure instance from a DioException
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badResponse:
        if (dioError.response != null) {
          return ServerFailure.fromResponse(
              dioError.response!.statusCode, dioError.response!.data);
        }
        return ServerFailure('Received an invalid response from the server.');

      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled');

      case DioExceptionType.unknown:
        final message = dioError.message ?? '';
        if (message.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        } else {
          return ServerFailure('Unexpected Error, Please try again!');
        }

      default:
        return ServerFailure('Oops! There was an error, Please try again');
    }
  }

  // Factory method to create a ServerFailure instance from an HTTP response
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    print("API Response: $response"); // Debugging line

    if (response is Map<String, dynamic>) {
      if (response.containsKey('message')) {
        return ServerFailure(response['message']);
      } else if (response.containsKey('error')) {
        return ServerFailure(response['error']);
      } else {
        return ServerFailure('Unknown error format.');
      }
    }

    return ServerFailure('Oops! There was an error, Please try again.');
  }
}
