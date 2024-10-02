import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:windmill_digital_poc/core/errors/network_exception.dart';
import 'package:windmill_digital_poc/core/errors/server_exception.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';

class ErrorHandler {
  static String handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is NetworkException) {
      return error.message;
    } else if (error is ServerException) {
      return error.message;
    } else if (error is SocketException) {
      return Strings.noInternetConnectionPleaseTryAgain;
    } else if (error is HttpException) {
      return Strings.serverRespondedWithError;
    } else {
      return "${Strings.anUnexpectedErrorOccurred} : ${error.toString()}";
    }
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Strings.connectionTimeoutPleaseTryAgain;
      case DioExceptionType.connectionError:
        return Strings.connectionFailedCheckYourConnection;
      case DioExceptionType.sendTimeout:
        return Strings.sendTimeoutPleaseTryAgain;
      case DioExceptionType.receiveTimeout:
        return Strings.receiveTimeoutPleaseTryAgain;
      case DioExceptionType.badResponse:
        return "${Strings.receivedInvalidStatusCode} : ${error.response?.statusCode}";
      case DioExceptionType.cancel:
        return Strings.requestToApiWasCancelled;
      case DioExceptionType.unknown:
        return Strings.connectionFailedCheckYourConnection;
      default:
        return Strings.anUnexpectedErrorOccurred;
    }
  }

  static String handleHiveError(dynamic error) {
    if (error is HiveError) {
      return "${Strings.hiveError}${error.message}";
    } else {
      return "${Strings.hiveUnknownError}${error.toString()}";
    }
  }
}
