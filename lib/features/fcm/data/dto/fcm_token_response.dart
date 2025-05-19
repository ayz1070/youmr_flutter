import '../../domain/entity/fcm_token_entity.dart';

class FcmTokenResponse {
  final int id;
  final String memberId;
  final String token;
  final String deviceType;
  final bool isActive;

  FcmTokenResponse({
    required this.id,
    required this.memberId,
    required this.token,
    required this.deviceType,
    required this.isActive,
  });

  factory FcmTokenResponse.fromJson(Map<String, dynamic> json) {
    return FcmTokenResponse(
      id: json['id'],
      memberId: json['memberId'],
      token: json['token'],
      deviceType: json['deviceType'],
      isActive: json['isActive'],
    );
  }

  FcmTokenEntity toEntity() {
    return FcmTokenEntity(
      id: id,
      memberId: memberId,
      token: token,
      deviceType: deviceType,
      isActive: isActive,
    );
  }
}