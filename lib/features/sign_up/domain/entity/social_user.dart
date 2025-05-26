import '../../../../core/constants/social_provider.dart';

class SocialUser {
  final String name;
  final String profileImage;
  final String socialId;
  final SocialProvider provider;
  final String? firebaseToken; // 추가

  SocialUser({
    required this.name,
    required this.profileImage,
    required this.socialId,
    required this.provider,
    this.firebaseToken,
  });
}