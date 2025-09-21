import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/src/features/counter/presentation/controller/controller.dart';
import 'package:riverpod_demo/src/features/counter/presentation/widgets/custom_floating_action_button.dart';

class CounterActions extends ConsumerWidget {
  const CounterActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterNotifier = ref.read(counterProvider.notifier);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomFloatingActionButton(
          heroTag: 'incrementFab',
          onPressed: counterNotifier.increment,
          tooltip: 'Increment',
          icon: Icons.add,
        ),
        const SizedBox(width: 20),
        CustomFloatingActionButton(
          heroTag: 'decrementFab',
          onPressed: counterNotifier.decrement,
          tooltip: 'Decrement',
          icon: Icons.remove,
        ),
      ],
    );
  }
}
