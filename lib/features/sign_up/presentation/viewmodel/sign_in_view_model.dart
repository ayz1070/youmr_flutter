import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/service/social_auth_service.dart';
import '../../domain/entity/social_user.dart';
import '../../domain/usecase/sign_in_with_social_account_use_case.dart';
import '../state/sign_in_state.dart';

class SignInViewModel extends StateNotifier<SignInState> {
  final SocialAuthService _socialAuthService;

  SignInViewModel(this._socialAuthService) : super(SignInState());

  Future<SocialUser?> loginWithGoogle() async {
    return await _socialAuthService.signInWithGoogle();
  }

  Future<SocialUser?> loginWithKakao() async {
    return await _socialAuthService.signInWithKakao();
  }
}