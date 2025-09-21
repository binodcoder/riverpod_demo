import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/src/features/chat/domain/chat_state.dart';
import 'package:riverpod_demo/src/features/chat/presentation/controllers/chat_controller.dart';
import 'package:riverpod_demo/src/features/chat/presentation/widgets/chat_bubble.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  late final ProviderSubscription<ChatState> _chatSubscription;

  @override
  void initState() {
    super.initState();
    _chatSubscription = ref.listenManual<ChatState>(
      chatControllerProvider,
      (previous, next) {
        final previousLength = previous?.messages.length ?? 0;
        if (next.messages.length != previousLength || next.isSending) {
          _scheduleScrollToBottom();
        }

        final previousError = previous?.errorMessage;
        final error = next.errorMessage;
        if (error != null && error.isNotEmpty && error != previousError) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(error)));
            ref.read(chatControllerProvider.notifier).resetError();
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _chatSubscription.close();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('AI Assistant')),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(chatState)),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      textInputAction: TextInputAction.send,
                      minLines: 1,
                      maxLines: 4,
                      onSubmitted: (_) => _handleSubmit(),
                      decoration: const InputDecoration(
                        hintText: 'Ask me about planning your grocery list... ',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: chatState.isSending ? null : _handleSubmit,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(ChatState chatState) {
    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          itemCount: chatState.messages.length + (chatState.isSending ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= chatState.messages.length) {
              return const _TypingIndicator();
            }

            final message = chatState.messages[index];
            return ChatBubble(message: message);
          },
        ),
        if (chatState.messages.isEmpty && !chatState.isSending)
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Ask the AI to help with meal ideas, shopping tips, or recipes.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  void _handleSubmit() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      return;
    }

    ref.read(chatControllerProvider.notifier).sendMessage(text);
    _textController.clear();
  }

  void _scheduleScrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) {
        return;
      }

      final position = _scrollController.position;
      _scrollController.animateTo(
        position.maxScrollExtent,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    });
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 48, top: 8, bottom: 8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2.2),
                ),
                SizedBox(width: 12),
                Text('Thinking...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
