import '../../domain/entity/attendance_entity.dart';

class AttendanceDto {
  final int id;
  final int memberId;
  final String memberName;
  final String memberProfileImageUrl;
  final DateTime attendanceDate;
  final String attendanceType;
  final DateTime createdAt;

  AttendanceDto({
    required this.id,
    required this.memberId,
    required this.memberName,
    required this.memberProfileImageUrl,
    required this.attendanceDate,
    required this.attendanceType,
    required this.createdAt,
  });

  factory AttendanceDto.fromJson(Map<String, dynamic> json) {
    return AttendanceDto(
      id: json['id'],
      memberId: json['memberId'],
      memberName: json['memberName'],
      memberProfileImageUrl: json['memberProfileImageUrl'],
      attendanceDate: DateTime.parse(json['attendanceDate']),
      attendanceType: json['attendanceType'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'memberName': memberName,
      'memberProfileImageUrl': memberProfileImageUrl,
      'attendanceDate': attendanceDate.toIso8601String(),
      'attendanceType': attendanceType,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  AttendanceEntity toEntity() {
    return AttendanceEntity(
      id: id,
      memberId: memberId,
      memberName: memberName,
      memberProfileImageUrl: memberProfileImageUrl,
      attendanceDate: attendanceDate,
      attendanceType: attendanceType,
      createdAt: createdAt,
    );
  }
}