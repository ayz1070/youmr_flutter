import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/service/gemini_service.dart';
import '../../domain/entity/gemini_message.dart';
import '../../domain/entity/gemini_sender.dart';
import '../state/gemini_state.dart';


class GeminiViewModel extends StateNotifier<GeminiState> {
  final GeminiService _service;

  GeminiViewModel(this._service) : super(const GeminiState());

  Future<void> sendPrompt(String questionText) async {
    if (state.isLoading || questionText.trim().isEmpty) return;

    final prompt = "$questionText";

    // 사용자 메시지 추가
    state = state.copyWith(
      messages: [...state.messages, GeminiMessage(sender: GeminiSender.user, text: prompt)],
      isLoading: true,
      streamingText: '',
    );

    try {
      final result = await _service.fetchAnswer(prompt);

      for (int i = 0; i <= result.length; i++) {
        await Future.delayed(const Duration(milliseconds: 20));
        state = state.copyWith(streamingText: result.substring(0, i));
      }

      state = state.copyWith(
        messages: [...state.messages, GeminiMessage(sender: GeminiSender.gemini, text: state.streamingText)],
        isLoading: false,
        streamingText: '',
      );
    } catch (e) {
      state = state.copyWith(
        messages: [...state.messages, GeminiMessage(sender: GeminiSender.gemini, text: "오류 발생: $e")],
        isLoading: false,
        streamingText: '',
      );
    }
  }

  void addWelcomeMessage(String userName) {
    if (state.messages.isNotEmpty) return;

    state = state.copyWith(
      messages: [
        ...state.messages,
        GeminiMessage(
          sender: GeminiSender.gemini,
          text: '안녕하세요 $userName님!\n\nYouMR AI 인사 박습니다!\n\n궁금한 점 있으면 질문주세요! (예 : C코드는 어떻게 잡아?)',
        ),
      ],
    );
  }

  void clear() {
    state = const GeminiState();
  }
}