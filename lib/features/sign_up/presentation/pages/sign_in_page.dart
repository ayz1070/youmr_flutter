import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youmr_flutter/features/sign_up/presentation/widgets/social_login_button.dart';
import '../../../../../core/di/auth_module.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 배경 이미지
          Image.asset(
            'lib/assets/images/bg_login.png',
            fit: BoxFit.cover,
          ),
          // 반투명 오버레이 (선택)
          Container(
            color: Colors.black.withOpacity(0.1), // 원하지 않으면 제거 가능
          ),
          // 로그인 버튼 영역
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),

                SocialLoginButton(
                  icon: 'lib/assets/icons/logo_kakao.svg',
                  label: '카카오톡으로 시작하기',
                  backgroundColor: const Color(0xFFFEE500),
                  textColor: Colors.black,
                  onPressed: () async {
                    final user = await ref
                        .read(signInViewModelProvider.notifier)
                        .loginWithKakao();
                    if (user != null) {
                      ref
                          .read(signUpViewModelProvider.notifier)
                          .updateFromSocialUser(user);
                      context.push('/sign-up');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('카카오 로그인 실패')),
                      );
                    }
                  },
                ),

                const SizedBox(height: 16),

                SocialLoginButton(
                  icon: 'lib/assets/icons/logo_google.svg',
                  label: '구글로 시작하기',
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  borderColor: Colors.grey,
                  onPressed: () async {
                    final user = await ref
                        .read(signInViewModelProvider.notifier)
                        .loginWithGoogle();
                    if (user != null) {
                      ref
                          .read(signUpViewModelProvider.notifier)
                          .updateFromSocialUser(user);
                      context.push('/sign-up');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('구글 로그인 실패')),
                      );
                    }
                  },
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}