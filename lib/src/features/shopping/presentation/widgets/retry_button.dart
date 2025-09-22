import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/src/features/shopping/presentation/controller/shopping_controller.dart';

class RetryButton extends ConsumerWidget {
  const RetryButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          ref.read(shoppingListProvider.notifier).refresh();
        },
        icon: const Icon(Icons.refresh),
        label: const Text('Retry'),
      ),
    );
  }
}
