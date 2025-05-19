class FcmTokenEntity {
  final int id;
  final String memberId;
  final String token;
  final String deviceType;
  final bool isActive;

  FcmTokenEntity({
    required this.id,
    required this.memberId,
    required this.token,
    required this.deviceType,
    required this.isActive,
  });

  FcmTokenEntity copyWith({
    int? id,
    String? memberId,
    String? token,
    String? deviceType,
    bool? isActive,
  }) {
    return FcmTokenEntity(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      token: token ?? this.token,
      deviceType: deviceType ?? this.deviceType,
      isActive: isActive ?? this.isActive,
    );
  }
}