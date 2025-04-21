// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDto _$MemberDtoFromJson(Map<String, dynamic> json) => MemberDto(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String,
      mbti: json['mbti'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$MemberDtoToJson(MemberDto instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'mbti': instance.mbti,
      'profileImageUrl': instance.profileImageUrl,
      'role': instance.role,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
