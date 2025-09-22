import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_demo/src/features/counter/data/fake_repository.dart';

part 'fake_counter_controller.g.dart';

@riverpod
String helloWorld(Ref ref) {
  return 'Hello, world!';
}

@Riverpod(keepAlive: true)
Stream<int> fakeCounter(Ref ref, int start) {
  final fP = ref.watch(fakeRepositoryProvider);
  return fP.fetchFakeData(start);
}
