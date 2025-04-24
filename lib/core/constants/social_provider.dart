enum SocialProvider {
  GOOGLE,
  KAKAO,
  APPLE,
  UNKNOWN,
}

extension SocialProviderExtension on SocialProvider {
  String get serverValue {
    switch (this) {
      case SocialProvider.GOOGLE:
        return 'GOOGLE';
      case SocialProvider.KAKAO:
        return 'KAKAO';
      case SocialProvider.APPLE:
        return 'APPLE';
      case SocialProvider.UNKNOWN:
        return 'UNKNOWN';
    }
  }

  static SocialProvider fromServerValue(String value) {
    switch (value) {
      case 'GOOGLE':
        return SocialProvider.GOOGLE;
      case 'KAKAO':
        return SocialProvider.KAKAO;
      case 'APPLE':
        return SocialProvider.APPLE;
      default:
        return SocialProvider.UNKNOWN;
    }
  }
}