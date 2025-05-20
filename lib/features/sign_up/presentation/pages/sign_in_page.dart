import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:logger/logger.dart';

import '../../../../../core/di/auth_module.dart';
import '../../../../core/constants/social_provider.dart';

// 생략된 import 및 클래스 선언은 그대로 유지

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  static final Logger _logger = Logger();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInViewModelProvider);
    final viewModel = ref.read(signInViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFB7C9BC),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              // ✅ 카카오 로그인 버튼
              InkWell(
                onTap: () async {
                  final kakaoUser = await kakaoLogin();
                  final account = kakaoUser?.kakaoAccount;

                  if (account != null) {
                    final name = account.profile?.nickname ?? '';
                    final profileImage = account.profile?.profileImageUrl ?? '';
                    final socialId = kakaoUser?.id.toString() ?? '';
                    final provider = SocialProvider.KAKAO;

                    final signUpViewModel = ref.read(signUpViewModelProvider.notifier);
                    signUpViewModel.updateName(name);
                    signUpViewModel.updateProfileImage(profileImage);
                    signUpViewModel.updateSocialId(socialId);
                    signUpViewModel.updateProvider(provider);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('카카오 로그인 성공')),
                    );

                    context.push('/sign-up');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('카카오 로그인 실패')),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(10),
                child: Ink(
                  child: Image.asset(
                    'lib/assets/images/btn_kakao.png',
                    width: double.infinity,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ✅ 구글 로그인 버튼
              InkWell(
                onTap: () async {
                  try {
                    final userCredential = await signInWithGoogle();
                    final user = userCredential.user;

                    if (user != null) {
                      final name = user.displayName ?? '';
                      final profileImage = user.photoURL ?? '';
                      final socialId = user.uid;
                      final provider = SocialProvider.GOOGLE;

                      final signUpViewModel = ref.read(signUpViewModelProvider.notifier);
                      signUpViewModel.updateName(name);
                      signUpViewModel.updateProfileImage(profileImage);
                      signUpViewModel.updateSocialId(socialId);
                      signUpViewModel.updateProvider(provider);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('구글 로그인 성공')),
                      );

                      context.push('/sign-up');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('구글 로그인 실패')),
                      );
                    }
                  } catch (e, stack) {
                    _logger.e('구글 로그인 실패', error: e, stackTrace: stack);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('구글 로그인 중 오류 발생')),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(10),
                child: Ink(
                  child: Image.asset(
                    'lib/assets/images/btn_google.png',
                    width: double.infinity,
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }

  Future<kakao.User?> kakaoLogin() async {
    try {
      if (await kakao.isKakaoTalkInstalled()) {
        await kakao.UserApi.instance.loginWithKakaoTalk();
        _logger.i('카카오톡으로 로그인 시도');
      } else {
        await kakao.UserApi.instance.loginWithKakaoAccount();
        _logger.i('카카오계정(웹)으로 로그인 시도');
      }

      final user = await kakao.UserApi.instance.me();
      _logger.i('카카오 로그인 성공');
      _logger.i('카카오ID: ${user.id}');
      _logger.i('닉네임: ${user.kakaoAccount?.profile?.nickname}');
      _logger.i('이메일: ${user.kakaoAccount?.email}');
      _logger.i('프로필사진: ${user.kakaoAccount?.profile?.profileImageUrl}');

      return user;
    } catch (e, stack) {
      _logger.e('카카오 로그인 실패', error: e, stackTrace: stack);
      return null;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw Exception('Google login canceled');
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}