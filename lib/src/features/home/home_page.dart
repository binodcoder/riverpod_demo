import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/src/features/counter/presentation/controller/controller.dart';
import 'package:riverpod_demo/src/features/chat/presentation/screens/chat_page.dart';
import 'package:riverpod_demo/src/features/counter/presentation/screens/counter_screen.dart';
import 'package:riverpod_demo/src/features/shopping/presentation/screens/shopping_page.dart';
import 'package:riverpod_demo/src/features/counter/presentation/widgets/counter_actions.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(helloWorldProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ChatPage()));
            },
            tooltip: 'Chat with AI assistant',
            icon: const Icon(Icons.chat_bubble_outline),
          ),
        ],
      ),
      body: Column(children: [CounterScreen(), ShoppingScreen()]),
      floatingActionButton: const CounterActions(),
    );
  }
}
