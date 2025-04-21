import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../dto/member_dto.dart';
import '../dto/social_sign_up_request_dto.dart';
import 'member_data_source.dart';

class MemberRemoteDataSource implements MemberDataSource {
  final Dio dio;
  final Logger logger = Logger();

  MemberRemoteDataSource({required String baseUrl})
      : dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    responseType: ResponseType.json,
    headers: {'Content-Type': 'application/json'},
  )) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.i('➡️ [Request] ${options.method} ${options.uri}');
          logger.d('Headers: ${options.headers}');
          logger.d('Body: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.i('⬅️ [Response] ${response.statusCode} ${response.requestOptions.uri}');
          logger.d('Response Data: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          logger.e('❌ [Error] ${e.message}');
          if (e.response != null) {
            logger.e('Error Response: ${e.response?.data}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future<MemberDto> signUpWithSocial(SocialSignUpRequestDto request) async {
    try {
      final response = await dio.post(
        '/api/v1/members/signup/social',
        data: request.toJson(),
      );

      return MemberDto.fromJson(response.data);
    } on DioException catch (e) {
      logger.e(_handleDioError(e, '회원가입 실패'));
      throw Exception(_handleDioError(e, '회원가입 실패'));
    }
  }

  @override
  Future<MemberDto> fetchMember(int memberId) async {
    try {
      final response = await dio.get('/api/v1/members/$memberId');

      return MemberDto.fromJson(response.data);
    } on DioException catch (e) {
      logger.e(_handleDioError(e, '회원 정보 조회 실패'));
      throw Exception(_handleDioError(e, '회원 정보 조회 실패'));
    }
  }

  @override
  Future<void> deleteMember(int memberId) async {
    try {
      final response = await dio.delete('/api/v1/members/$memberId');
      if (response.statusCode != 200) {
        logger.w('⚠️ 회원 삭제 실패: ${response.statusCode}');
        throw Exception('회원 삭제 실패: ${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e(_handleDioError(e, '회원 삭제 실패'));
      throw Exception(_handleDioError(e, '회원 삭제 실패'));
    }
  }

  // 에러 메시지를 처리하는 함수 추가
  String _handleDioError(DioException e, String defaultMessage) {
    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 400:
          return '$defaultMessage: 잘못된 요청입니다.';
        case 401:
          return '$defaultMessage: 인증되지 않은 사용자입니다.';
        case 403:
          return '$defaultMessage: 권한이 없습니다.';
        case 404:
          return '$defaultMessage: 요청한 데이터를 찾을 수 없습니다.';
        case 500:
          return '$defaultMessage: 서버 오류가 발생했습니다.';
      }
    }
    return '$defaultMessage: ${e.message}';
  }
}