import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_demo/src/features/shopping/data/categories.dart';
import 'package:riverpod_demo/src/features/shopping/domain/grocery.dart';

part 'controller.g.dart';

@riverpod
String helloWorld(Ref ref) {
  return 'Hello, world!';
}

@riverpod
class Counter extends _$Counter {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state = state + 1;
  }

  void decrement() {
    state = state - 1;
  }
}

@riverpod
class ShoppingList extends _$ShoppingList {
  @override
  FutureOr<List<Grocery>> build() async {
    return _loadItems();
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

    final url = Uri.https(
      'binodfolio-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json',
    );

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      state = previous;
      throw Exception('Failed to delete grocery item');
    }
  }

  Future<List<Grocery>> _loadItems() async {
    final url = Uri.https(
      'binodfolio-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch data');
    }

    if (response.body == 'null') {
      return const [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<Grocery> loadedItems = [];
    for (final entry in listData.entries) {
      final category =
          categories.entries
              .firstWhere(
                (catItem) => catItem.value.title == entry.value['category'],
              )
              .value;

      loadedItems.add(
        Grocery(
          id: entry.key,
          name: entry.value['name'],
          quantity: entry.value['quantity'],
          category: category,
        ),
      );
    }

    return loadedItems;
  }
}
