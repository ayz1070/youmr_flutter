import '../entity/attendance_entity.dart';
import '../repository/attendance_repository.dart';

class FetchAttendancesUseCase {
  final AttendanceRepository repository;

  FetchAttendancesUseCase(this.repository);

  Future<List<AttendanceEntity>> call() {
    return repository.fetchAttendances();
  }
}