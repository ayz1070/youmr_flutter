import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_entity.dart';
import '../../../../core/constants/social_provider.dart';

part 'social_sign_up_request_dto.g.dart';

@JsonSerializable()
class SocialSignUpRequestDto {
  final String provider;
  final String socialId;
  final String nickname;
  final String profileImageUrl;
  final String mbti;

  SocialSignUpRequestDto({
    required this.provider,
    required this.socialId,
    required this.nickname,
    required this.profileImageUrl,
    required this.mbti,
  });

  factory SocialSignUpRequestDto.fromJson(Map<String, dynamic> json) => _$SocialSignUpRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SocialSignUpRequestDtoToJson(this);

  /// **DTO → Entity 변환**
  UserEntity toEntity() {
    return UserEntity(
      id: socialId,
      nickname: nickname,
      mbti: mbti,
      profileImage: profileImageUrl,
      provider: SocialProvider.values.firstWhere(
            (e) => e.name.toUpperCase() == provider.toUpperCase(),
      ),
      providerId: socialId,
    );
  }
}