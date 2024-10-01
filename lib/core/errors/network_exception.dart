import 'package:windmill_digital_poc/core/resources/strings.dart';

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = Strings.networkErrorOccurred]);
}
