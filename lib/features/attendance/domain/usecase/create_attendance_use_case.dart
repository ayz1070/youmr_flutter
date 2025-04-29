import '../entity/attendance_entity.dart';
import '../repository/attendance_repository.dart';

class CreateAttendanceUseCase {
  final AttendanceRepository repository;

  CreateAttendanceUseCase(this.repository);

  Future<AttendanceEntity> call({
    required int memberId,
    required DateTime attendanceDate,
    required String attendanceType,
  }) {
    return repository.createAttendance(
      memberId: memberId,
      attendanceDate: attendanceDate,
      attendanceType: attendanceType,
    );
  }
}