import 'chat_message.dart';

class ChatState {
  const ChatState({
    this.messages = const <ChatMessage>[],
    this.isSending = false,
    this.errorMessage,
  });

  final List<ChatMessage> messages;
  final bool isSending;
  final String? errorMessage;

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isSending,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
