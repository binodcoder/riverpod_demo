import 'package:riverpod_demo/src/core/exceptions/app_exception.dart';

class ForbiddenException extends AppException {
  ForbiddenException(super.message);
}
