enum MemberRole {
  admin,
  developer,
  member,
  offlineMember;

  /// 서버에서 받은 문자열을 enum으로 변환
  static MemberRole fromString(String value) {
    return MemberRole.values.firstWhere(
          (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => MemberRole.member,
    );
  }

  /// 서버로 보낼 때 문자열로 변환
  String toJson() => name;
}