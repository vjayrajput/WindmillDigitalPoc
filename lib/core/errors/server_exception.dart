import 'package:windmill_digital_poc/core/resources/strings.dart';

class ServerException implements Exception {
  final String message;

  ServerException([this.message = Strings.serverErrorOccurred]);
}
