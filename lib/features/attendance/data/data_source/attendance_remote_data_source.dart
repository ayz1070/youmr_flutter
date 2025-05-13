import 'package:dio/dio.dart';
import '../../../../core/error/error_handler.dart';
import '../dto/attendance_dto.dart';
import '../dto/create_attendance_request_dto.dart';
import '../dto/delete_attendance_request_dto.dart';
import 'attendance_data_source.dart';

class AttendanceRemoteDataSource implements AttendanceDataSource {
  final Dio dio;

  AttendanceRemoteDataSource({required this.dio});

  static const String _endpoint = '/attendances';

  @override
  Future<List<AttendanceDto>> fetchAttendances() async {
    try {
      final response = await dio.get(_endpoint);
      final List<dynamic> data = response.data;
      return data.map((e) => AttendanceDto.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(handleDioError(e, '출석 리스트 조회 실패'));
    }
  }

  @override
  Future<AttendanceDto> createAttendance(CreateAttendanceRequestDto request) async {
    try {
      final response = await dio.post(_endpoint, data: request.toJson());
      return AttendanceDto.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(handleDioError(e, '출석 생성 실패'));
    }
  }

  @override
  Future<void> deleteAttendance(DeleteAttendanceRequestDto request) async {
    try {
      final response = await dio.delete(_endpoint, queryParameters: request.toQueryParameters());
      if (response.statusCode != 204) {
        throw Exception('출석 삭제 실패: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(handleDioError(e, '출석 삭제 실패'));
    }
  }
}