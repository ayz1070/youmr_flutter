// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberResponse _$MemberResponseFromJson(Map<String, dynamic> json) =>
    MemberResponse(
      id: (json['id'] as num).toInt(),
      socialId: json['socialId'] as String,
      provider: json['provider'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$MemberResponseToJson(MemberResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'socialId': instance.socialId,
      'provider': instance.provider,
      'name': instance.name,
      'nickname': instance.nickname,
      'profileImageUrl': instance.profileImageUrl,
      'role': instance.role,
    };
