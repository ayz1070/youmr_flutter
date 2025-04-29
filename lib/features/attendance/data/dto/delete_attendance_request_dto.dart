class DeleteAttendanceRequestDto {
  final int memberId;
  final DateTime attendanceDate;
  final String attendanceType;

  DeleteAttendanceRequestDto({
    required this.memberId,
    required this.attendanceDate,
    required this.attendanceType,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      'memberId': memberId,
      'attendanceDate': attendanceDate.toIso8601String().split('T').first,
      'attendanceType': attendanceType,
    };
  }
}