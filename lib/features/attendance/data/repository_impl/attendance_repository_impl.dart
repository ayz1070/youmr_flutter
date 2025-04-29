import '../../domain/entity/attendance_entity.dart';
import '../../domain/repository/attendance_repository.dart';
import '../data_source/attendance_data_source.dart';
import '../dto/create_attendance_request_dto.dart';
import '../dto/delete_attendance_request_dto.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceDataSource remoteDataSource;

  AttendanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AttendanceEntity>> fetchAttendances() async {
    final dtos = await remoteDataSource.fetchAttendances();
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<AttendanceEntity> createAttendance({
    required int memberId,
    required DateTime attendanceDate,
    required String attendanceType,
  }) async {
    final request = CreateAttendanceRequestDto(
      memberId: memberId,
      attendanceDate: attendanceDate,
      attendanceType: attendanceType,
    );

    final dto = await remoteDataSource.createAttendance(request);
    return dto.toEntity();
  }

  @override
  Future<void> deleteAttendance({
    required int memberId,
    required DateTime attendanceDate,
    required String attendanceType,
  }) async {
    final request = DeleteAttendanceRequestDto(
      memberId: memberId,
      attendanceDate: attendanceDate,
      attendanceType: attendanceType,
    );

    await remoteDataSource.deleteAttendance(request);
  }
}