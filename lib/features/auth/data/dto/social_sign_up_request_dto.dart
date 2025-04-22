import 'package:json_annotation/json_annotation.dart';
import '../../../../core/constants/social_provider.dart';
import '../../domain/entity/member_entity.dart';

part 'social_sign_up_request_dto.g.dart';

@JsonSerializable()
class SocialSignUpRequestDto {
  final String socialId;
  final String provider;
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

  factory SocialSignUpRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SocialSignUpRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SocialSignUpRequestDtoToJson(this);

  factory SocialSignUpRequestDto.fromEntity(MemberEntity entity) {
    return SocialSignUpRequestDto(
      socialId: entity.socialId,
      provider: entity.provider.name,
      name: entity.name,
      nickname: entity.nickname,
      profileImageUrl: entity.profileImage,
    );
  }
}