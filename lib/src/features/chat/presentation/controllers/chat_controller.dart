import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';

import 'package:riverpod_demo/src/features/chat/data/ai_chat_repository.dart';
import 'package:riverpod_demo/src/features/chat/domain/chat_message.dart';
import 'package:riverpod_demo/src/features/chat/domain/chat_state.dart';

part 'chat_controller.g.dart';

@riverpod
AiChatRepository aiChatRepository(Ref ref) {
  final repository = AiChatRepository();
  ref.onDispose(repository.dispose);
  return repository;
}

@Riverpod(keepAlive: true)
class ChatController extends _$ChatController {
  @override
  ChatState build() {
    ref.keepAlive();
    return const ChatState();
  }

  Future<void> sendMessage(String rawPrompt) async {
    final prompt = rawPrompt.trim();
    if (prompt.isEmpty || state.isSending) {
      return;
    }

    final previousMessages = state.messages;
    final userMessage = ChatMessage.user(prompt);

    state = state.copyWith(
      messages: [...previousMessages, userMessage],
      isSending: true,
      clearErrorMessage: true,
    );

    try {
      final reply = await ref.read(aiChatRepositoryProvider).sendMessage(
            history: previousMessages,
            prompt: prompt,
          );

      state = state.copyWith(
        messages: [...previousMessages, userMessage, reply],
        isSending: false,
      );
    } catch (error) {
      state = state.copyWith(
        messages: [...previousMessages, userMessage],
        isSending: false,
        errorMessage: _mapError(error),
      );
    }
  }

  void resetError() {
    if (!state.hasError) {
      return;
    }
    state = state.copyWith(clearErrorMessage: true);
  }

  String _mapError(Object error) {
    if (error is StateError) {
      return error.message;
    }
    return error.toString();
  }
}
