import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/src/features/counter/presentation/controller/fake_counter_controller.dart';
import 'package:riverpod_demo/src/features/counter/presentation/controller/counter_controller.dart';
import 'package:riverpod_demo/src/features/counter/presentation/widgets/counter_actions.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  void _refresh(WidgetRef ref) {
    ref.invalidate(fakeCounterProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fakeCounter = ref.watch(fakeCounterProvider(10));
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Page'),
        actions: [
          IconButton(onPressed: () => _refresh(ref), icon: Icon(Icons.refresh)),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(counter.toString()),
            SizedBox(height: 20),
            Text(
              fakeCounter
                  .when(
                    data: (int value) => value,
                    error: (Object e, _) => e,
                    loading: () => 0,
                  )
                  .toString(),

              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: const CounterActions(),
    );
  }
}
