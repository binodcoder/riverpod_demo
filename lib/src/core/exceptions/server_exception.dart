import 'package:riverpod_demo/src/core/exceptions/app_exception.dart';

class ServerException extends AppException {
  final int statusCode;
  ServerException(String message, this.statusCode, [dynamic originalError])
    : super(message, originalError);
}
