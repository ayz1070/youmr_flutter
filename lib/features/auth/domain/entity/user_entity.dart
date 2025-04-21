import '../../../../core/constants/social_provider.dart';

class UserEntity {
  final String id;
  final String? email;
  final String nickname;
  final String mbti;
  final String profileImage;

  // SocialProvider enum 타입으로 변경
  final SocialProvider? provider;
  final String? providerId;

  final String? gender;

  UserEntity({
    required this.id,
    this.email,
    required this.nickname,
    required this.mbti,
    required this.profileImage,
    this.provider,
    this.providerId,
    this.gender,
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? nickname,
    String? mbti,
    String? profileImage,
    SocialProvider? provider,
    String? providerId,

    String? gender,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      mbti: mbti ?? this.mbti,
      profileImage: profileImage ?? this.profileImage,
      provider: provider ?? this.provider,
      providerId: providerId ?? this.providerId,
      gender: gender ?? this.gender,
    );
  }
}