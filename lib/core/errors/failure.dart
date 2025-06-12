import 'package:dio/dio.dart';

// Abstract class representing a failure during API calls
abstract class Failure {
  final String errMessage;

  Failure(this.errMessage);
}

// Concrete subclass of Failure for server-related errors
class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response?.statusCode, dioError.response?.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled');
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please try again!');
      default:
        return ServerFailure('Oops! There was an error, Please try again');
    }
  }

  // Add this factory method
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400) {
      return ServerFailure('لقد قمت بتقييم هذه الصيدلية من قبل');
    } else if (statusCode == 404) {
      return ServerFailure('Not found');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error');
    } else if (response is Map<String, dynamic>) {
      if (response.containsKey('message')) {
        return ServerFailure(response['message']);
      } else if (response.containsKey('error')) {
        return ServerFailure(response['error']);
      }
    }
    return ServerFailure('Oops! There was an error, Please try again');
  }
}
