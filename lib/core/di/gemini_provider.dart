import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/gemini/data/service/gemini_service.dart';
import '../../features/gemini/presentation/state/gemini_state.dart';
import '../../features/gemini/presentation/viewmodel/gemini_view_model.dart';

final geminiViewModelProvider =
StateNotifierProvider<GeminiViewModel, GeminiState>(
      (ref) => GeminiViewModel(GeminiService()),
);