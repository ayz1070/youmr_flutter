enum Role {
  admin,
  developer,
  member,
  offlineMember,
}

extension RoleExtension on Role {
  /// enum → 서버용 문자열
  String get serverValue {
    switch (this) {
      case Role.admin:
        return 'ADMIN';
      case Role.developer:
        return 'DEVELOPER';
      case Role.member:
        return 'MEMBER';
      case Role.offlineMember:
        return 'OFFLINE_MEMBER';
    }
  }

  /// 서버 문자열 → enum
  static Role fromServerValue(String value) {
    switch (value) {
      case 'ADMIN':
        return Role.admin;
      case 'DEVELOPER':
        return Role.developer;
      case 'MEMBER':
        return Role.member;
      case 'OFFLINE_MEMBER':
        return Role.offlineMember;
      default:
        return Role.member; // fallback
    }
  }
}