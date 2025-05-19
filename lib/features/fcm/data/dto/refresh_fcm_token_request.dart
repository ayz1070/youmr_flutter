class RefreshFcmTokenRequest {
  final String memberId;
  final String token;
  final String deviceType;

  RefreshFcmTokenRequest({
    required this.memberId,
    required this.token,
    required this.deviceType,
  });

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
      'token': token,
      'device_type': deviceType,
    };
  }
}