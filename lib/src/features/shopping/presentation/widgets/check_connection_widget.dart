import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/src/features/shopping/presentation/widgets/retry_button.dart';

class CheckConnectionWidget extends ConsumerWidget {
  const CheckConnectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off, size: 56, color: theme.colorScheme.error),
          const SizedBox(height: 12),
          Text(
            'No internet connection',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Please check your connection and try again.',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const RetryButton(),
        ],
      ),
    );
  }
}
