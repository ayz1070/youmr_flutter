import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;

import '../../../../core/constants/social_provider.dart';
import '../../domain/entity/social_user.dart';

class SocialAuthService {
  Future<SocialUser?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    if (user == null) return null;
    return SocialUser(
      name: user.displayName ?? '',
      profileImage: user.photoURL ?? '',
      socialId: user.uid,
      provider: SocialProvider.GOOGLE,
    );
  }

  Future<SocialUser?> signInWithKakao() async {
    if (await kakao.isKakaoTalkInstalled()) {
      await kakao.UserApi.instance.loginWithKakaoTalk();
    } else {
      await kakao.UserApi.instance.loginWithKakaoAccount();
    }
    final user = await kakao.UserApi.instance.me();
    final account = user.kakaoAccount;
    if (account == null) return null;
    return SocialUser(
      name: account.profile?.nickname ?? '',
      profileImage: account.profile?.profileImageUrl ?? '',
      socialId: user.id.toString(),
      provider: SocialProvider.KAKAO,
    );
  }
}
