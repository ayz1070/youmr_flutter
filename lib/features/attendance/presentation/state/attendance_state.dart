class AttendanceState {
  final List<Map<String, String>> attendees;

  AttendanceState({this.attendees = const []});

  AttendanceState copyWith({
    List<Map<String, String>>? attendees,
  }) {
    return AttendanceState(
      attendees: attendees ?? this.attendees,
    );
  }
}