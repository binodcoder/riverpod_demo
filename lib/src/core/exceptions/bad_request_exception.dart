import 'package:riverpod_demo/src/core/exceptions/app_exception.dart';

class BadRequestException extends AppException {
  BadRequestException(super.message);
}
