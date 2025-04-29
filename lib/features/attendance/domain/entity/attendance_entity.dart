class AttendanceEntity {
  final int id;
  final int memberId;
  final String memberName;
  final String memberProfileImageUrl;
  final DateTime attendanceDate;
  final String attendanceType;
  final DateTime createdAt;

  const AttendanceEntity({
    required this.id,
    required this.memberId,
    required this.memberName,
    required this.memberProfileImageUrl,
    required this.attendanceDate,
    required this.attendanceType,
    required this.createdAt,
  });
}