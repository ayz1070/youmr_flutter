class CreateAttendanceRequestDto {
  final int memberId;
  final DateTime attendanceDate;
  final String attendanceType;

  CreateAttendanceRequestDto({
    required this.memberId,
    required this.attendanceDate,
    required this.attendanceType,
  });

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'attendanceDate': attendanceDate.toIso8601String().split('T').first, // yyyy-MM-dd 형식
      'attendanceType': attendanceType,
    };
  }
}