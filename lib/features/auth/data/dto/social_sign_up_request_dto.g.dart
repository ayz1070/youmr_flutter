// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_sign_up_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialSignUpRequestDto _$SocialSignUpRequestDtoFromJson(
        Map<String, dynamic> json) =>
    SocialSignUpRequestDto(
      provider: json['provider'] as String,
      socialId: json['socialId'] as String,
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      mbti: json['mbti'] as String,
    );

Map<String, dynamic> _$SocialSignUpRequestDtoToJson(
        SocialSignUpRequestDto instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'socialId': instance.socialId,
      'nickname': instance.nickname,
      'profileImageUrl': instance.profileImageUrl,
      'mbti': instance.mbti,
    };
