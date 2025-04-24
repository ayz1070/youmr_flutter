import 'package:youmr_flutter/features/sign_up/domain/entity/role.dart';

import '../../../../core/constants/social_provider.dart';

class SignUpState {
  final String name;
  final String nickname;
  final String profileImage;
  final String email;         // 추가
  final SocialProvider provider;
  final String socialId;
  final Role role;
  final bool isLoading;
  final String? errorMessage; // 추가
  final bool isCompleted;     // 추가

  SignUpState({
    this.name = '',
    this.nickname = '',
    this.profileImage = '',
    this.email = '',
    this.provider = SocialProvider.KAKAO,
    this.socialId = '',
    this.role = Role.offlineMember,
    this.isLoading = false,
    this.errorMessage,
    this.isCompleted = false,
  });

  SignUpState copyWith({
    String? name,
    String? nickname,
    String? profileImage,
    String? email,
    SocialProvider? provider,
    String? socialId,
    Role? role,
    bool? isLoading,
    String? errorMessage,
    bool? isCompleted,
  }) {
    return SignUpState(
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      profileImage: profileImage ?? this.profileImage,
      email: email ?? this.email,
      provider: provider ?? this.provider,
      socialId: socialId ?? this.socialId,
      role: role ?? this.role,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}