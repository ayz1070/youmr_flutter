import '../../../../core/constants/social_provider.dart';
import '../../domain/entity/role.dart';
import '../../domain/entity/week_type.dart';
import '../../domain/entity/member_entity.dart';

class SignUpResponse {
  final int id;
  final String socialId;
  final SocialProvider provider;
  final String name;
  final String nickname;
  final String profileImageUrl;
  final Role role;
  final WeekType? weekType;
  final String firebaseToken;

  SignUpResponse({
    required this.id,
    required this.socialId,
    required this.provider,
    required this.name,
    required this.nickname,
    required this.profileImageUrl,
    required this.role,
    this.weekType,
    required this.firebaseToken,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      id: json['id'] as int? ?? 0,
      socialId: json['socialId'] as String,
      provider: SocialProviderExtension.fromServerValue(json['provider'] as String),
      name: json['name'] as String,
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      role: RoleExtension.fromServerValue(json['role'] as String),
      weekType: json['weekType'] != null
          ? WeekType.values.firstWhere(
            (e) => e.name == json['weekType'],
        orElse: () => WeekType.MONDAY,
      )
          : null,
      firebaseToken: json['firebaseToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'socialId': socialId,
      'provider': provider.serverValue,
      'name': name,
      'nickname': nickname,
      'profileImageUrl': profileImageUrl,
      'role': role.serverValue,
      if (weekType != null) 'weekType': weekType!.name,
      'firebaseToken': firebaseToken,
    };
  }

  MemberEntity toEntity() => MemberEntity(
    id: id,
    socialId: socialId,
    provider: provider,
    name: name,
    nickname: nickname,
    profileImage: profileImageUrl,
    role: role,
    weekType: weekType,
  );
}