import '../../domain/entity/gemini_message.dart';

class GeminiState {
  final List<GeminiMessage> messages;
  final bool isLoading;
  final String streamingText;

  const GeminiState({
    this.messages = const [],
    this.isLoading = false,
    this.streamingText = '',
  });

  GeminiState copyWith({
    List<GeminiMessage>? messages,
    bool? isLoading,
    String? streamingText,
  }) {
    return GeminiState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      streamingText: streamingText ?? this.streamingText,
    );
  }
}