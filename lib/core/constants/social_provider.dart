// lib/core/constants/social_provider.dart

enum SocialProvider {
  GOOGLE,
  KAKAO,
  APPLE, // 애플 로그인 추가 가능
  UNKNOWN,
}

extension SocialProviderExtension on SocialProvider {
  String get value {
    switch (this) {
      case SocialProvider.GOOGLE:
        return 'GOOGLE';
      case SocialProvider.KAKAO:
        return 'KAKAO';
      case SocialProvider.APPLE:
        return 'APPLE';
      case SocialProvider.UNKNOWN:
        return "UNKNOWN";
    }
  }

  // String to SocialProvider 변환
  static SocialProvider fromString(String value) {
    return SocialProvider.values.firstWhere(
          (e) => e.value == value,
      orElse: () => SocialProvider.UNKNOWN,
    );
  }
}