import '../repository/attendance_repository.dart';

class DeleteAttendanceUseCase {
  final AttendanceRepository repository;

  DeleteAttendanceUseCase(this.repository);

  Future<void> call({
    required int memberId,
    required DateTime attendanceDate,
    required String attendanceType,
  }) {
    return repository.deleteAttendance(
      memberId: memberId,
      attendanceDate: attendanceDate,
      attendanceType: attendanceType,
    );
  }
}