import 'package:json_annotation/json_annotation.dart';
import '../../../../core/constants/social_provider.dart';
import '../../domain/entity/role.dart';
import '../../domain/entity/member_entity.dart'; // 실제 Entity 경로에 맞게 수정

class SocialSignUpRequestDto {
  final String socialId;
  final SocialProvider provider;
  final String name;
  final String nickname;
  final String profileImageUrl;

  SocialSignUpRequestDto({
    required this.socialId,
    required this.provider,
    required this.name,
    required this.nickname,
    required this.profileImageUrl,
  });

  Map<String, dynamic> toJson() => {
    'socialId': socialId,
    'provider': provider.serverValue,
    'name': name,
    'nickname': nickname,
    'profileImageUrl': profileImageUrl,
  };

  factory SocialSignUpRequestDto.fromJson(Map<String, dynamic> json) =>
      SocialSignUpRequestDto(
        socialId: json['socialId'] as String,
        provider: SocialProviderExtension.fromServerValue(json['provider'] as String),
        name: json['name'] as String,
        nickname: json['nickname'] as String,
        profileImageUrl: json['profileImageUrl'] as String,
      );

  /// [추가] DTO → 도메인 Entity 변환 (id, role은 기본값/임시값 세팅)
  MemberEntity toEntity({int id = 0, Role role = Role.member}) {
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