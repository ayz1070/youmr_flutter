import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_flutter/features/attendance/domain/usecase/delete_attendance_use_case.dart';
import 'package:youmr_flutter/features/splash/presentation/provider/member_provider.dart';

import '../../domain/usecase/create_attendance_use_case.dart';
import '../../domain/usecase/fetch_attendance_use_case.dart';
import '../state/attendance_state.dart';

class AttendanceViewModel extends StateNotifier<AttendanceState> {
  final CreateAttendanceUseCase createAttendanceUseCase;
  final DeleteAttendanceUseCase deleteAttendanceUseCase;
  final FetchAttendancesUseCase fetchAttendancesUseCase;
  final Ref ref;

  AttendanceViewModel({
    required this.createAttendanceUseCase,
    required this.deleteAttendanceUseCase,
    required this.fetchAttendancesUseCase,
    required this.ref,
  }) : super(AttendanceState());

  Future<void> fetchAttendances() async {
    final entities = await fetchAttendancesUseCase.call();
    final attendeeList = entities
        .map((e) => {
      'name': e.memberName,
      'profileImageUrl': e.memberProfileImageUrl,
    })
        .toList();

    state = state.copyWith(attendees: attendeeList);
  }

  Future<Map<String, String>> attend() async {
    final member = ref.read(memberProvider);
    if (member == null) {
      throw Exception('로그인된 사용자가 없습니다.');
    }

    await createAttendanceUseCase.call(
      memberId: member.id!, // 🔥 null 아님 보장 필요
      attendanceDate: DateTime.now(),
      attendanceType: 'DEFAULT',
    );

    final newAttendee = {
      'name': member.name,
      'profileImageUrl': member.profileImage,
    };

    state = state.copyWith(attendees: [...state.attendees, newAttendee]);

    return newAttendee;
  }

  Future<void> cancelAttend() async {
    final member = ref.read(memberProvider);
    if (member == null) {
      throw Exception('⚠ 로그인된 사용자가 없습니다.');
    }

    await deleteAttendanceUseCase.call(
      memberId: member.id!,
      attendanceDate: DateTime.now(),
      attendanceType: 'DEFAULT',
    );

    // 최신 출석 리스트 갱신
    await fetchAttendances();
  }
}