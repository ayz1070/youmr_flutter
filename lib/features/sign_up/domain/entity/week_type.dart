// 📁 domain/entity/week_type.dart
enum WeekType {
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURSDAY,
  FRIDAY,
  SATURDAY,
  SUNDAY,
  NONE,
}

extension WeekTypeExtension on WeekType {
  String get serverValue {
    return name; // 서버에서 enum 이름 그대로 사용 시
  }

  String get label {
    switch (this) {
      case WeekType.MONDAY:
        return '월요일';
      case WeekType.TUESDAY:
        return '화요일';
      case WeekType.WEDNESDAY:
        return '수요일';
      case WeekType.THURSDAY:
        return '목요일';
      case WeekType.FRIDAY:
        return '금요일';
      case WeekType.SATURDAY:
        return '토요일';
      case WeekType.SUNDAY:
        return '일요일';
      case WeekType.NONE:
        return "없음";
    }
  }
}
