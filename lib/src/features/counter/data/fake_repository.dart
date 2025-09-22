import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fake_repository.g.dart';

abstract class FakeRepository {
  Stream<int> fetchFakeData([int initialValue]);
}

class FakeRepositoryImpl implements FakeRepository {
  @override
  Stream<int> fetchFakeData([int initialValue = 5]) async* {
    int i = initialValue;
    while (true) {
      yield i++;
      await Future.delayed(Duration(milliseconds: 400));
    }
  }
}

@Riverpod(keepAlive: true)
FakeRepository fakeRepository(Ref ref) {
  return FakeRepositoryImpl();
}
