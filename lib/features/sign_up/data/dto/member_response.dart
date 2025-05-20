import 'package:json_annotation/json_annotation.dart';
import '../../../../core/constants/social_provider.dart';
import '../../domain/entity/role.dart';
import '../../domain/entity/member_entity.dart';
import '../../domain/entity/week_type.dart'; // 실제 Entity 경로에 맞게 수정


class MemberResponse {
  final int id;
  final String socialId;
  final SocialProvider provider;
  final String name;
  final String nickname;
  final String profileImageUrl;
  final Role role;
  final WeekType? weekType; // ✅ 새 필드

  MemberResponse({
    required this.id,
    required this.socialId,
    required this.provider,
    required this.name,
    required this.nickname,
    required this.profileImageUrl,
    required this.role,
    this.weekType,
  });

  factory MemberResponse.fromJson(Map<String, dynamic> json) => MemberResponse(
    id: json['id'] as int,
    socialId: json['socialId'] as String,
    provider: SocialProviderExtension.fromServerValue(json['provider'] as String),
    name: json['name'] as String,
    nickname: json['nickname'] as String,
    profileImageUrl: json['profileImageUrl'] as String,
    role: RoleExtension.fromServerValue(json['role'] as String),
    weekType: json['weekType'] != null
        ? WeekType.values.firstWhere(
          (e) => e.name == json['weekType'],
      orElse: () => WeekType.MONDAY,
    )
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'socialId': socialId,
    'provider': provider.serverValue,
    'name': name,
    'nickname': nickname,
    'profileImageUrl': profileImageUrl,
    'role': role.serverValue,
    if (weekType != null) 'weekType': weekType!.name,
  };

  /// DTO → 도메인 Entity 변환
  MemberEntity toEntity() {
    return MemberEntity(
      id: id,
      socialId: socialId,
      provider: provider,
      name: name,
      nickname: nickname,
      profileImage: profileImageUrl,
      role: role,
      weekType: weekType,
    );
  }
}