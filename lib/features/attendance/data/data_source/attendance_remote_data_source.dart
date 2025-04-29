import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../dto/attendance_dto.dart';
import '../dto/create_attendance_request_dto.dart';
import '../dto/delete_attendance_request_dto.dart';
import 'attendance_data_source.dart';

class AttendanceRemoteDataSource implements AttendanceDataSource {
  final Dio dio;
  final Logger logger = Logger();

  AttendanceRemoteDataSource({required String baseUrl})
      : dio = Dio(BaseOptions(
    baseUrl: "$baseUrl/api/v1",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    responseType: ResponseType.json,
    headers: {'Content-Type': 'application/json'},
  )) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.i('[Request] ${options.method} ${options.uri}');
          logger.d('Headers: ${options.headers}');
          logger.d('Body: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.i('[Response] ${response.statusCode} ${response.requestOptions.uri}');
          logger.d('Response Data: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          logger.e('[Error] ${e.message}');
          if (e.response != null) {
            logger.e('Error Response: ${e.response?.data}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  static const String _attendanceEndpoint = '/attendances';

  @override
  Future<List<AttendanceDto>> fetchAttendances() async {
    try {
      final response = await dio.get('$_attendanceEndpoint');
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((item) => AttendanceDto.fromJson(item)).toList();
    } on DioException catch (e) {
      logger.e(_handleDioError(e, '출석 리스트 조회 실패'));
      throw Exception(_handleDioError(e, '출석 리스트 조회 실패'));
    }
  }

  @override
  Future<AttendanceDto> createAttendance(CreateAttendanceRequestDto request) async {
    try {
      final response = await dio.post(
        '$_attendanceEndpoint',
        data: request.toJson(),
      );
      return AttendanceDto.fromJson(response.data);
    } on DioException catch (e) {
      logger.e(_handleDioError(e, '출석 생성 실패'));
      throw Exception(_handleDioError(e, '출석 생성 실패'));
    }
  }

  @override
  Future<void> deleteAttendance(DeleteAttendanceRequestDto request) async {
    try {
      final response = await dio.delete(
        '$_attendanceEndpoint',
        queryParameters: request.toQueryParameters(),
      );
      if (response.statusCode != 204) {
        logger.w('출석 삭제 실패: ${response.statusCode}');
        throw Exception('출석 삭제 실패: ${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e(_handleDioError(e, '출석 삭제 실패'));
      throw Exception(_handleDioError(e, '출석 삭제 실패'));
    }
  }

  // 에러 메시지 처리
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
          return '$defaultMessage: 요청한 출석 데이터를 찾을 수 없습니다.';
        case 500:
          return '$defaultMessage: 서버 오류가 발생했습니다.';
      }
    }
    return '$defaultMessage: ${e.message}';
  }
}