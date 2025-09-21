import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_demo/src/core/exceptions/bad_request_exception.dart';
import 'package:riverpod_demo/src/core/exceptions/forbidden_exception.dart';
import 'package:riverpod_demo/src/core/exceptions/not_found_exception.dart';
import 'package:riverpod_demo/src/core/exceptions/server_exception.dart';
import 'package:riverpod_demo/src/core/exceptions/unauthorized_exception.dart';

import 'package:riverpod_demo/src/features/shopping/data/categories.dart';
import 'package:riverpod_demo/src/features/shopping/domain/category.dart';
import 'package:riverpod_demo/src/features/shopping/domain/grocery.dart';

part 'shopping_repository.g.dart';

abstract class ShoppingRepository {
  Future<List<Grocery>> fetchGroceries();

  Future<Grocery> addGroceries({
    required String name,
    required int quantity,
    required Category category,
  });

  Future<Grocery> updateGroceries({
    required String id,
    required String name,
    required int quantity,
    required Category category,
  });

  Future<void> deleteGrocery(String id);

  void dispose();
}

class HttpShoppingRepository implements ShoppingRepository {
  HttpShoppingRepository({
    http.Client? client,
    this.databaseHost = 'inodfolio-default-rtdb.firebaseio.com',
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final String databaseHost;

  @override
  Future<List<Grocery>> fetchGroceries() async {
    final response = await _client.get(_buildUri());

    // --- Add the switch / mapping here ---
    switch (response.statusCode) {
      case 400:
        throw BadRequestException('Bad request');
      case 401:
        throw UnauthorizedException('Unauthorized');
      case 403:
        throw ForbiddenException('Forbidden');
      case 404:
        throw NotFoundException('Groceries not found');
      case 500:
        throw ServerException('Internal server error', response.statusCode);
      default:
        if (response.statusCode >= 400 && response.statusCode < 500) {
          throw http.ClientException('Client error: ${response.statusCode}');
        } else if (response.statusCode >= 500) {
          throw ServerException(
            'Server error: ${response.statusCode}',
            response.statusCode,
          );
        }
    }

    // --- Continue with body parsing ---
    if (response.body.trim() == 'null') return const [];

    final decoded = json.decode(response.body) as Map<String, dynamic>?;
    if (decoded == null || decoded.isEmpty) return const [];

    return decoded.entries
        .map((entry) => _mapEntry(entry.key, entry.value))
        .toList(growable: false);
  }

  @override
  Future<Grocery> addGroceries({
    required String name,
    required int quantity,
    required Category category,
  }) async {
    final response = await _client.post(
      _buildUri(),
      headers: const {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'quantity': quantity,
        'category': category.title,
      }),
    );

    if (response.statusCode >= 400) {
      throw Exception('Failed to add grocery item');
    }

    final decoded = json.decode(response.body) as Map<String, dynamic>?;
    final id = decoded?['name'] as String?;

    if (id == null || id.isEmpty) {
      throw StateError('Unexpected response when creating grocery item.');
    }

    return Grocery(id: id, name: name, quantity: quantity, category: category);
  }

  @override
  Future<Grocery> updateGroceries({
    required String id,
    required String name,
    required int quantity,
    required Category category,
  }) async {
    final response = await _client.patch(
      _buildUri(id),
      headers: const {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'quantity': quantity,
        'category': category.title,
      }),
    );

    if (response.statusCode >= 400) {
      throw Exception('Failed to update grocery item');
    }

    return Grocery(id: id, name: name, quantity: quantity, category: category);
  }

  @override
  Future<void> deleteGrocery(String id) async {
    final response = await _client.delete(_buildUri(id));

    if (response.statusCode >= 400) {
      throw Exception('Failed to delete grocery item');
    }
  }

  @override
  void dispose() {
    _client.close();
  }

  Uri _buildUri([String? groceryId]) {
    final path =
        groceryId == null
            ? 'shopping-list.json'
            : 'shopping-list/$groceryId.json';
    return Uri.https(databaseHost, path);
  }

  Grocery _mapEntry(String id, dynamic value) {
    if (value is! Map<String, dynamic>) {
      throw StateError('Unexpected grocery payload for id $id.');
    }

    final categoryTitle = value['category'] as String?;
    final category = _resolveCategory(categoryTitle);

    return Grocery(
      id: id,
      name: value['name'] as String? ?? 'Unknown',
      quantity: (value['quantity'] as num?)?.toInt() ?? 1,
      category: category,
    );
  }

  Category _resolveCategory(String? title) {
    return categories.values.firstWhere(
      (category) => category.title == title,
      orElse: () => categories[CategoryType.other]!,
    );
  }
}

@Riverpod(keepAlive: true)
ShoppingRepository shoppingRepository(Ref ref) {
  final repository = HttpShoppingRepository();
  ref.onDispose(repository.dispose);
  return repository;
}
