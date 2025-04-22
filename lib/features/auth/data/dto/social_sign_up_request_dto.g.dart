// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_sign_up_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialSignUpRequestDto _$SocialSignUpRequestDtoFromJson(
  Map<String, dynamic> json,
) => SocialSignUpRequestDto(
  socialId: json['socialId'] as String,
  provider: json['provider'] as String,
  name: json['name'] as String,
  nickname: json['nickname'] as String,
  profileImageUrl: json['profileImageUrl'] as String,
);

Map<String, dynamic> _$SocialSignUpRequestDtoToJson(
  SocialSignUpRequestDto instance,
) => <String, dynamic>{
  'socialId': instance.socialId,
  'provider': instance.provider,
  'name': instance.name,
  'nickname': instance.nickname,
  'profileImageUrl': instance.profileImageUrl,
};
