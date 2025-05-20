import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:youmr_flutter/core/constants/social_provider.dart';
import '../../domain/entity/role.dart';
import '../../domain/entity/social_user.dart';
import '../../domain/entity/week_type.dart';
import '../../domain/usecase/sign_up_with_social_account_use_case.dart';
import '../state/sign_up_state.dart';

class SignUpViewModel extends StateNotifier<SignUpState> {
  final SignUpWithSocialAccountUseCase _signUpWithSocialAccountUseCase;
  final Logger _logger = Logger();

  SignUpViewModel(this._signUpWithSocialAccountUseCase) : super(SignUpState());

  void updateFromSocialUser(SocialUser user) {
    state = state.copyWith(
      name: user.name,
      profileImage: user.profileImage,
      socialId: user.socialId,
      provider: user.provider,
    );
    logState();
  }

  void updateNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
    logState();
  }

  void updateProfileImage(String profileImage) {
    state = state.copyWith(profileImage: profileImage);
    logState();
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
    logState();
  }

  void updateRole(Role role) {
    state = state.copyWith(role: role);
    logState();
  }

  void updateWeekType(WeekType weekType) {
    state = state.copyWith(weekType: weekType);
    logState();
  }

  void setOfflineMember(bool isOffline) {
    state = state.copyWith(role: isOffline ? Role.offlineMember : Role.member);
  }

  void resetError() {
    state = state.copyWith(errorMessage: null);
  }

  // 실제 회원가입 로직
  Future<bool> signUp() async {
    state = state.copyWith(isLoading: true, errorMessage: null, isCompleted: false);

    _logger.i("""
      🚀 회원가입 요청:
      이름: ${state.name}, 닉네임: ${state.nickname}, 
      프로필이미지: ${state.profileImage}, provider: ${state.provider},
      socialId: ${state.socialId}, role: ${state.role}
    """);

    try {
      final user = await _signUpWithSocialAccountUseCase.call(
        socialId: state.socialId,
        nickname: state.nickname,
        provider: state.provider,
        name: state.name,
        profileImage: state.profileImage,
        role: state.role,
      );

      if (user != null) {
        _logger.i("회원가입 성공: 사용자 ID=${user.id}");
        state = state.copyWith(isLoading: false, isCompleted: true);
        return true;
      } else {
        _logger.w("회원가입 실패: 서버에서 null 반환");
        state = state.copyWith(isLoading: false, errorMessage: "회원가입 실패");
        return false;
      }
    } catch (e) {
      _logger.e("회원가입 중 예외 발생: $e");
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  // 상태 로그 출력 (개발/디버깅 용)
  void logState() {
    _logger.i("""
    [SignUpState 업데이트]
    이름: ${state.name}
    닉네임: ${state.nickname}
    프로필 이미지: ${state.profileImage}
    provider: ${state.provider}
    socialId: ${state.socialId}
    role: ${state.role}
    isLoading: ${state.isLoading}
    errorMessage: ${state.errorMessage}
    isCompleted: ${state.isCompleted}
    """);
  }
}