class SignInState {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;

  SignInState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
  });

  // copyWith 메서드: 불변 객체처럼 사용
  SignInState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}