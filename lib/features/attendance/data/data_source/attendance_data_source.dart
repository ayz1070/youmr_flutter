import '../dto/attendance_dto.dart';
import '../dto/create_attendance_request_dto.dart';
import '../dto/delete_attendance_request_dto.dart';

abstract class AttendanceDataSource {
  Future<List<AttendanceDto>> fetchAttendances();

  Future<AttendanceDto> createAttendance(CreateAttendanceRequestDto request);

  Future<void> deleteAttendance(DeleteAttendanceRequestDto request);
}