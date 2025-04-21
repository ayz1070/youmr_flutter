import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../domain/usecase/sign_up_with_social_account_use_case.dart';
import '../state/sign_up_state.dart';

class SignUpViewModel extends StateNotifier<SignUpState> {
  final SignUpWithSocialAccountUseCase _signUpWithSocialAccountUseCase;
  final Logger _logger = Logger(); // ✅ Logger 인스턴스 추가

  SignUpViewModel(this._signUpWithSocialAccountUseCase) : super(SignUpState());

  Future<bool> signUp({
    required String nickname,
    required String mbti,
    required String profileImagePath,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    _logger.i("🚀 회원가입 요청: 닉네임=$nickname, MBTI=$mbti, 프로필 이미지=$profileImagePath");

    try {
      final user = await _signUpWithSocialAccountUseCase.call(
        nickname: nickname,
        mbti: mbti,
        profileImage: profileImagePath,
      );

      if (user != null) {
        _logger.i("✅ 회원가입 성공: 사용자 ID=${user.id}");
        state = state.copyWith(isLoading: false);
        return true; // 성공 시 true 반환
      } else {
        _logger.w("❌ 회원가입 실패");
        state = state.copyWith(isLoading: false, errorMessage: '회원가입 실패');
        return false;
      }
    } catch (e) {
      _logger.e("🔥 회원가입 중 예외 발생: $e");
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  // ✅ 닉네임 변경 로그 추가
  void updateNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
    logState();
  }

  // ✅ MBTI 변경 로그 추가
  void updateMbti(String mbti) {
    state = state.copyWith(mbti: mbti);
    logState();
  }

  // ✅ 프로필 이미지 변경 로그 추가
  void updateProfileImageUrl(String url) {
    state = state.copyWith(profileImageUrl: url);
    logState();
  }

  // ✅ 현재 상태를 출력하는 로그 메서드
  void logState() {
    _logger.i("""
    📌 [회원가입 상태 업데이트]
    📝 닉네임: ${state.nickname ?? "미입력"}
    🔄 MBTI: ${state.mbti ?? "미선택"}
    📸 프로필 이미지: ${state.profileImage ?? "미선택"}
    """);
  }
}