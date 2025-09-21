import 'package:riverpod_demo/src/core/exceptions/app_exception.dart';

class NotFoundException extends AppException {
  NotFoundException(super.message);
}
