import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:youmr_flutter/core/util/app_logger.dart';

class GeminiService {
  final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  late final Dio _dio;

  GeminiService() {
    final endpoint =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-lite:generateContent?key=$_apiKey';

    _dio = Dio(
      BaseOptions(
        baseUrl: endpoint,
        contentType: 'application/json',
      ),
    );
  }

  Future<String> fetchAnswer(String promptText) async {
    final data = {
      "contents": [
        {
          "parts": [
            {"text":  "음악 또는 악기에 관련된 정보가 궁금해" + promptText + "핵심 내용만 짧고 간단하게 제공해줘"}
          ]
        }
      ]
    };

    try {
      final response = await _dio.post('', data: data);
      AppLogger.i("Response : ${response}");
      final content = response.data['candidates']?[0]?['content']?['parts']?[0]?['text'];
      return content ?? "결과 없음";
    } catch (e) {
      AppLogger.e(e);
      throw Exception("Gemini 호출 오류: $e");
    }
  }
}