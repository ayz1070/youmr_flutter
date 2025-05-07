import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_flutter/features/attendance/domain/usecase/delete_attendance_use_case.dart';

import '../../domain/usecase/create_attendance_use_case.dart';
import '../../domain/usecase/fetch_attendance_use_case.dart';
import '../state/attendance_state.dart';

class AttendanceViewModel extends StateNotifier<AttendanceState> {
  final CreateAttendanceUseCase createAttendanceUseCase;
  final DeleteAttendanceUseCase deleteAttendanceUseCase;
  final FetchAttendancesUseCase fetchAttendancesUseCase;

  AttendanceViewModel({
    required this.createAttendanceUseCase,
    required this.deleteAttendanceUseCase,
    required this.fetchAttendancesUseCase,
  }) : super(AttendanceState());

  Future<void> fetchAttendances() async {
    final entities = await fetchAttendancesUseCase.call();
    final attendeeList =
        entities
            .map(
              (e) => {
                'name': e.memberName,
                'profileImageUrl': e.memberProfileImageUrl,
              },
            )
            .toList();

    state = state.copyWith(attendees: attendeeList);
  }

  Future<Map<String, String>> attend() async {
    const int memberId = 1;

    await createAttendanceUseCase.call(
      memberId: memberId,
      attendanceDate: DateTime.now(),
      attendanceType: 'DEFAULT',
    );

    final entities = await fetchAttendancesUseCase.call();
    final newEntity = entities.last; // 방금 출석한 정보라 가정
    return {
      'name': newEntity.memberName,
      'profileImageUrl': newEntity.memberProfileImageUrl,
    };
  }

  Future<void> cancelAttend() async {
    int memberId = 1;

    await deleteAttendanceUseCase.call(
      memberId: memberId,
      attendanceDate: DateTime.now(),
      attendanceType: "DEFAULT",
    );

    await fetchAttendances();
  }


}
