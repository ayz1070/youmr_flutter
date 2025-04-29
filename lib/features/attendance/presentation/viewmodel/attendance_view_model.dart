import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecase/create_attendance_use_case.dart';
import '../../domain/usecase/fetch_attendance_use_case.dart';
import '../state/attendance_state.dart';

class AttendanceViewModel extends StateNotifier<AttendanceState> {
  final CreateAttendanceUseCase createAttendanceUseCase;
  final FetchAttendancesUseCase fetchAttendancesUseCase;

  AttendanceViewModel({
    required this.createAttendanceUseCase,
    required this.fetchAttendancesUseCase,
  }) : super(AttendanceState());

  Future<void> fetchAttendances() async {
    final entities = await fetchAttendancesUseCase.call();
    final attendeeList = entities.map((e) => {
      'name': e.memberName,
      'profileImageUrl': e.memberProfileImageUrl,
    }).toList();

    state = state.copyWith(attendees: attendeeList);
  }

  Future<void> attend() async {
    // 여기서 로그인된 사용자 정보가 필요함 (예: memberId를 가져와야 함)
    // 임시로 memberId = 1로 설정
    const int memberId = 1;

    await createAttendanceUseCase.call(
      memberId: memberId,
      attendanceDate: DateTime.now(),
      attendanceType: 'DEFAULT',
    );

    await fetchAttendances();
  }
}