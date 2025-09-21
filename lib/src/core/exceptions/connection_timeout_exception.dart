import 'package:riverpod_demo/src/core/exceptions/app_exception.dart';

class ConnectionTimeoutException extends AppException {
  ConnectionTimeoutException(super.message, [super.originalError]);
}
