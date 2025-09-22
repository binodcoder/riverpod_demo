import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/src/core/exceptions/connection_timeout_exception.dart';
import 'package:riverpod_demo/src/core/exceptions/network_exception.dart';
import 'package:riverpod_demo/src/core/exceptions/server_exception.dart';
import 'package:riverpod_demo/src/features/shopping/presentation/controller/shopping_controller.dart';
import 'package:riverpod_demo/src/features/shopping/presentation/widgets/grocery_item.dart';
import 'package:riverpod_demo/src/features/shopping/presentation/widgets/retry_button.dart';
import 'package:riverpod_demo/src/features/shopping/presentation/widgets/check_connection_widget.dart';

class ShoppingScreen extends ConsumerWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceries = ref.watch(shoppingListProvider);
    return Expanded(
      child: groceries.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) {
          if (error is ConnectionTimeoutException) {
            return RetryButton();
          } else if (error is NetworkException) {
            return CheckConnectionWidget();
          } else if (error is ServerException) {
            return Text('Server error: ${error.statusCode}');
          }

          return Center(child: Text('Failed to load groceries: $error}'));
        },

        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No item added yet'));
          }

          final theme = Theme.of(context);
          final cardMargin =
              theme.cardTheme.margin ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
          final dismissalColor = theme.colorScheme.error.withValues(
            alpha: 0.55,
          );

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              final item = items[index];

              return Dismissible(
                key: ValueKey(item.id),
                background: Container(
                  color: dismissalColor,
                  margin: cardMargin,
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (_) async {
                  final messenger = ScaffoldMessenger.of(context);
                  try {
                    await ref
                        .read(shoppingListProvider.notifier)
                        .removeItem(item);
                    messenger.showSnackBar(
                      const SnackBar(content: Text('Grocery item deleted')),
                    );
                  } catch (_) {
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Delete failed. Restored item.'),
                      ),
                    );
                  }
                },
                child: GroceryItem(
                  name: item.name,
                  color: item.category.color,
                  quantity: item.quantity,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
