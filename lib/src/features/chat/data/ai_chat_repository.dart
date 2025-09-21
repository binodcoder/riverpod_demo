import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/chat_message.dart';

class AiChatRepository {
  AiChatRepository({
    http.Client? client,
    String? apiKey,
    this.model = 'gpt-3.5-turbo',
    this.baseUrl = 'https://api.openai.com/v1',
    this.systemPrompt =
        'You are a friendly grocery assistant helping users with shopping lists.',
  })  : _client = client ?? http.Client(),
        _apiKey = apiKey ?? const String.fromEnvironment('OPENAI_API_KEY');

  final http.Client _client;
  final String _apiKey;
  final String baseUrl;
  final String model;
  final String systemPrompt;

  bool get hasValidKey => _apiKey.isNotEmpty;

  Future<ChatMessage> sendMessage({
    required List<ChatMessage> history,
    required String prompt,
  }) async {
    if (!hasValidKey) {
      throw StateError(
        'Missing OpenAI API key. Pass it via --dart-define=OPENAI_API_KEY=your_key.',
      );
    }

    final uri = Uri.parse('$baseUrl/chat/completions');
    final payload = <String, dynamic>{
      'model': model,
      'messages': [
        {'role': 'system', 'content': systemPrompt},
        ...history.map(
          (message) => {
            'role': _mapRole(message.role),
            'content': message.content,
          },
        ),
        {'role': 'user', 'content': prompt},
      ],
      'temperature': 0.2,
    };

    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode >= 400) {
      final message = response.body.isEmpty
          ? 'OpenAI request failed with status ${response.statusCode}'
          : response.body;
      throw Exception(message);
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = decoded['choices'] as List<dynamic>?;
    if (choices == null || choices.isEmpty) {
      throw StateError('OpenAI returned an empty response.');
    }

    final message = choices.first['message'] as Map<String, dynamic>;
    final content = message['content'] as String?;
    if (content == null || content.trim().isEmpty) {
      throw StateError('OpenAI response did not contain text.');
    }

    return ChatMessage.assistant(content);
  }

  void dispose() {
    _client.close();
  }

  String _mapRole(ChatRole role) {
    switch (role) {
      case ChatRole.user:
        return 'user';
      case ChatRole.assistant:
        return 'assistant';
      case ChatRole.system:
        return 'system';
    }
  }
}
