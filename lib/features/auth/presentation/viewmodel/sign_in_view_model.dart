import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecase/sign_in_with_social_account_use_case.dart';
import '../state/sign_in_state.dart';

class SignInViewModel extends StateNotifier<SignInState> {
  final SignInWithSocialAccountUseCase _signInWithSocialAccountUseCase;

  SignInViewModel(this._signInWithSocialAccountUseCase) : super(SignInState());

  Future<void> signIn() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // try {
    //   await _signInWithSocialAccountUseCase.call(
    //     email: state.email,
    //     password: state.password,
    //   );
    //   state = state.copyWith(isLoading: false);
    //   // 로그인 성공 후 다음 화면으로 이동 로직 추가 가능
    // } catch (e) {
    //   state = state.copyWith(isLoading: false, errorMessage: e.toString());
    // }
  }

  void updateEmail(String email) => state = state.copyWith(email: email);
  void updatePassword(String password) => state = state.copyWith(password: password);
}