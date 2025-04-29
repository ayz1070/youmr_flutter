import '../entity/attendance_entity.dart';

abstract class AttendanceRepository {
  Future<List<AttendanceEntity>> fetchAttendances();

  Future<AttendanceEntity> createAttendance({
    required int memberId,
    required DateTime attendanceDate,
    required String attendanceType,
  });

  Future<void> deleteAttendance({
    required int memberId,
    required DateTime attendanceDate,
    required String attendanceType,
  });
}