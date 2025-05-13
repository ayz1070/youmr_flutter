import 'package:dio/dio.dart';

String handleDioError(DioException e, String defaultMessage) {
  if (e.response != null) {
    switch (e.response?.statusCode) {
      case 400:
        return '$defaultMessage: 잘못된 요청입니다.';
      case 401:
        return '$defaultMessage: 인증되지 않은 사용자입니다.';
      case 403:
        return '$defaultMessage: 권한이 없습니다.';
      case 404:
        return '$defaultMessage: 요청한 리소스를 찾을 수 없습니다.';
      case 500:
        return '$defaultMessage: 서버 오류가 발생했습니다.';
    }
  }
  return '$defaultMessage: ${e.message}';
}