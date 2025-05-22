import 'gemini_sender.dart';


class GeminiMessage {
  final GeminiSender sender;
  final String text;

  const GeminiMessage({
    required this.sender,
    required this.text,
  });
}