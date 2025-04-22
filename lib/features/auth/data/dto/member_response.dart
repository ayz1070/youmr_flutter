import 'package:json_annotation/json_annotation.dart';
import '../../../../core/constants/social_provider.dart';
import '../../domain/entity/member_entity.dart';
import '../../domain/entity/member_role.dart';

part 'member_response.g.dart';

@JsonSerializable()
class MemberResponse {
  final int id;
  final String socialId;
  final String provider;
  final String name;
  final String nickname;
  final String profileImageUrl;
  final String role;

  MemberResponse({
    required this.id,
    required this.socialId,
    required this.provider,
    required this.name,
    required this.nickname,
    required this.profileImageUrl,
    required this.role,
  });

  factory MemberResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberResponseToJson(this);

  MemberEntity toEntity() {
    return MemberEntity(
      id: id,
      socialId: socialId,
      provider: SocialProvider.values.firstWhere(
            (e) => e.name.toLowerCase() == provider.toLowerCase(),
        orElse: () => SocialProvider.KAKAO, // fallback 지정
      ),
      name: name,
      nickname: nickname,
      profileImage: profileImageUrl,
      role: MemberRole.values.firstWhere(
            (e) => e.name.toLowerCase() == role.toLowerCase(),
        orElse: () => MemberRole.member,
      ),
    );
  }
}