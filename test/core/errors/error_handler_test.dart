import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:windmill_digital_poc/core/errors/error_handler.dart';
import 'package:windmill_digital_poc/core/errors/network_exception.dart';
import 'package:windmill_digital_poc/core/errors/server_exception.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';

void main() {
  group('ErrorHandler handleError', () {
    test('should return correct message for Dio connectionTimeout', () {
      final dioException = DioException(
        type: DioExceptionType.connectionTimeout,
        requestOptions: RequestOptions(path: ''),
      );

      final result = ErrorHandler.handleError(dioException);

      expect(result, Strings.connectionTimeoutPleaseTryAgain);
    });

    test('should return correct message for Dio badResponse', () {
      final dioException = DioException(
        type: DioExceptionType.badResponse,
        response:
            Response(statusCode: 500, requestOptions: RequestOptions(path: '')),
        requestOptions: RequestOptions(path: ''),
      );

      final result = ErrorHandler.handleError(dioException);

      expect(result, "${Strings.receivedInvalidStatusCode} : 500");
    });

    test('should return network error message for NetworkException', () {
      final networkException = NetworkException();

      final result = ErrorHandler.handleError(networkException);

      expect(result, Strings.networkErrorOccurred);
    });

    test('should return server error message for ServerException', () {
      final serverException = ServerException();

      final result = ErrorHandler.handleError(serverException);

      expect(result, Strings.serverErrorOccurred);
    });

    test('should return no internet message for SocketException', () {
      const socketException = SocketException('Failed');

      final result = ErrorHandler.handleError(socketException);

      expect(result, Strings.noInternetConnectionPleaseTryAgain);
    });

    test('should return server error message for HttpException', () {
      const httpException = HttpException('404 Not Found');

      final result = ErrorHandler.handleError(httpException);

      expect(result, Strings.serverRespondedWithError);
    });

    test('should return an unexpected error for unknown error', () {
      final unknownError = Exception('Unknown error');

      final result = ErrorHandler.handleError(unknownError);

      expect(result,
          "${Strings.anUnexpectedErrorOccurred} : ${unknownError.toString()}");
    });
  });

  group('ErrorHandler handleHiveError', () {
    test('should return correct message for HiveError', () {
      final hiveError = HiveError('Some Hive error');

      final result = ErrorHandler.handleHiveError(hiveError);

      expect(result, "${Strings.hiveError}Some Hive error");
    });

    test('should return an unknown hive error for unknown error', () {
      final unknownError = Exception('Unknown Hive error');

      final result = ErrorHandler.handleHiveError(unknownError);

      expect(result, "${Strings.hiveUnknownError}${unknownError.toString()}");
    });
  });
}
