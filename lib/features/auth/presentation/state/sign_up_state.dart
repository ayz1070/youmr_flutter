class SignUpState {
  final String nickname;
  final String mbti;
  final String profileImage;
  final bool isLoading;
  final String? errorMessage;

  SignUpState({
    this.nickname = '',
    this.mbti = '',
    this.profileImage = '',
    this.isLoading = false,
    this.errorMessage,
  });

  // copyWith 메서드: 불변 객체처럼 사용
  SignUpState copyWith({
    String? nickname,
    String? mbti,
    String? profileImageUrl,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SignUpState(
      nickname: nickname ?? this.nickname,
      mbti: mbti ?? this.mbti,
      profileImage: profileImageUrl ?? this.profileImage,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
