import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_demo/src/features/shopping/data/shopping_repository.dart';
import 'package:riverpod_demo/src/features/shopping/domain/grocery.dart';

part 'shopping_controller.g.dart';

@riverpod
class ShoppingList extends _$ShoppingList {
  @override
  FutureOr<List<Grocery>> build() {
    return ref.watch(shoppingRepositoryProvider).fetchGroceries();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadItems);
  }

  Future<void> removeItem(Grocery item) async {
    final previous = state;

    state = state.whenData(
      (items) => items
          .where((element) => element.id != item.id)
          .toList(growable: false),
    );

    try {
      await ref.read(shoppingRepositoryProvider).deleteGrocery(item.id);
    } catch (_) {
      state = previous;
      rethrow;
    }
  }

  Future<List<Grocery>> _loadItems() {
    return ref.read(shoppingRepositoryProvider).fetchGroceries();
  }
}
