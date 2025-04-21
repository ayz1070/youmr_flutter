import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_entity.dart';
import '../../../../core/constants/social_provider.dart';

part 'member_dto.g.dart';

@JsonSerializable()
class MemberDto {
  final int id;
  final String nickname;
  final String mbti;
  final String profileImageUrl;
  final String role;
  final String status;
  final String createdAt; // 서버에서 받은 시간 값

  MemberDto({
    required this.id,
    required this.nickname,
    required this.mbti,
    required this.profileImageUrl,
    required this.role,
    required this.status,
    required this.createdAt,
  });

  /// **JSON → DTO 변환**
  factory MemberDto.fromJson(Map<String, dynamic> json) => _$MemberDtoFromJson(json);

  /// **DTO → JSON 변환**
  Map<String, dynamic> toJson() => _$MemberDtoToJson(this);

  /// **DTO → Entity 변환**
  UserEntity toEntity() {
    return UserEntity(
      id: id.toString(),
      nickname: nickname,
      mbti: mbti,
      profileImage: profileImageUrl,
    );
  }
}