import '../../../../core/constants/social_provider.dart';
import 'member_role.dart';

class MemberEntity {
  final int? id;
  final String socialId; // 소셜 로그인 식별자
  final SocialProvider provider; // enum: KAKAO, GOOGLE, APPLE
  final String name;
  final String nickname;
  final String profileImage;
  final MemberRole? role;

  const MemberEntity({
    this.id,
    required this.socialId,
    required this.provider,
    required this.name,
    required this.nickname,
    required this.profileImage,
    this.role,
  });

  MemberEntity copyWith({
    int? id,
    String? socialId,
    SocialProvider? provider,
    String? name,
    String? nickname,
    String? profileImage,
    MemberRole? role,
  }) {
    return MemberEntity(
      id: id ?? this.id,
      socialId: socialId ?? this.socialId,
      provider: provider ?? this.provider,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
    );
  }
}