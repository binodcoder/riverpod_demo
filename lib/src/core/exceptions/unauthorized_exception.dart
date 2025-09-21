import 'package:riverpod_demo/src/core/exceptions/app_exception.dart';

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message);
}
