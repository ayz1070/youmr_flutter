import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_flutter/core/theme/app_colors.dart';
import 'package:youmr_flutter/features/gemini/presentation/widget/chat_input_field.dart';

import '../../../../core/di/gemini_provider.dart';
import '../../domain/entity/gemini_sender.dart';

class GeminiPage extends ConsumerStatefulWidget {
  const GeminiPage({super.key});

  @override
  ConsumerState<GeminiPage> createState() => _GeminiPageState();
}

class _GeminiPageState extends ConsumerState<GeminiPage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 유저 이름을 여기에 직접 하드코딩하거나 Provider로 받을 수도 있음
    Future.microtask(() {
      ref.read(geminiViewModelProvider.notifier).addWelcomeMessage("철수");
    });
  }

  void _handleSend() {
    final text = _controller.text.trim();
    _controller.clear();
    ref.read(geminiViewModelProvider.notifier).sendPrompt(text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(geminiViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('YouMR AI', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.messages.length + (state.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < state.messages.length) {
                  final message = state.messages[index];
                  final isUser = message.sender == GeminiSender.user;
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isUser ? AppColors.primary : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: isUser ? AppColors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(state.streamingText),
                    ),
                  );
                }
              },
            ),
          ),
          ChatInputField(controller: _controller, onSend: _handleSend),
          SizedBox(height: 1),
        ],
      ),
    );
  }
}
