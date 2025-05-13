import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_config.dart';
import '../util/app_logger.dart';

// dio 의존성 주입
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  )
    ..interceptors.add(_defaultInterceptor());
});


Interceptor _defaultInterceptor() => InterceptorsWrapper(
  onRequest: (options, handler) {
    AppLogger.i('[Request] ${options.method} ${options.uri}');
    return handler.next(options);
  },
  onResponse: (response, handler) {
    AppLogger.i('[Response] ${response.statusCode} ${response.requestOptions.uri}');
    return handler.next(response);
  },
  onError: (DioException e, handler) {
    AppLogger.e('[Error] ${e.message}');
    return handler.next(e);
  },
);