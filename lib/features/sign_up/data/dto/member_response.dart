import 'package:json_annotation/json_annotation.dart';
import '../../../../core/constants/social_provider.dart';
import '../../domain/entity/role.dart';
import '../../domain/entity/member_entity.dart'; // 실제 Entity 경로에 맞게 수정

@JsonSerializable()
class MemberResponse {
  final int id;
  final String socialId;
  final SocialProvider provider;
  final String name;
  final String nickname;
  final String profileImageUrl;
  final Role role;

  MemberResponse({
    required this.id,
    required this.socialId,
    required this.provider,
    required this.name,
    required this.nickname,
    required this.profileImageUrl,
    required this.role,
  });

  factory MemberResponse.fromJson(Map<String, dynamic> json) => MemberResponse(
    id: json['id'] as int,
    socialId: json['socialId'] as String,
    provider: SocialProviderExtension.fromServerValue(json['provider'] as String),
    name: json['name'] as String,
    nickname: json['nickname'] as String,
    profileImageUrl: json['profileImageUrl'] as String,
    role: RoleExtension.fromServerValue(json['role'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'socialId': socialId,
    'provider': provider.serverValue,
    'name': name,
    'nickname': nickname,
    'profileImageUrl': profileImageUrl,
    'role': role.serverValue,
  };

  /// [추가] DTO → 도메인 Entity 변환
  MemberEntity toEntity() {
    return MemberEntity(
      id: id,
      socialId: socialId,
      provider: provider,
      name: name,
      nickname: nickname,
      profileImage: profileImageUrl,
      role: role,
    );
  }
}