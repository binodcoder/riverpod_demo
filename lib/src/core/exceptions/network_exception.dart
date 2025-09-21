import 'package:riverpod_demo/src/core/exceptions/app_exception.dart';

class NetworkException extends AppException {
  NetworkException(super.message, [super.originalError]);
}
