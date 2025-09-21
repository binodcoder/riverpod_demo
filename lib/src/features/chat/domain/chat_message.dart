enum ChatRole { user, assistant, system }

class ChatMessage {
  ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  factory ChatMessage.user(String content) {
    final now = DateTime.now();
    return ChatMessage(
      id: now.microsecondsSinceEpoch.toString(),
      role: ChatRole.user,
      content: content.trim(),
      createdAt: now,
    );
  }

  factory ChatMessage.assistant(String content) {
    final now = DateTime.now();
    return ChatMessage(
      id: now.microsecondsSinceEpoch.toString(),
      role: ChatRole.assistant,
      content: content.trim(),
      createdAt: now,
    );
  }

  final String id;
  final ChatRole role;
  final String content;
  final DateTime createdAt;

  ChatMessage copyWith({
    String? id,
    ChatRole? role,
    String? content,
    DateTime? createdAt,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
