import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:youmr_flutter/features/sign_up/presentation/widgets/google_sign_in_button.dart';

import '../../../../../core/di/auth_module.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),

            // 카카오 로그인
            InkWell(
              onTap: () async {
                final user =
                    await ref
                        .read(signInViewModelProvider.notifier)
                        .loginWithKakao();
                if (user != null) {
                  ref
                      .read(signUpViewModelProvider.notifier)
                      .updateFromSocialUser(user);
                  context.push('/sign-up');
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('카카오 로그인 실패')));
                }
              },
              child: Image.asset('lib/assets/images/btn_kakao.png'),
            ),

            const SizedBox(height: 16),

            GoogleSignInButton(
              onPressed: () async {
                final user =
                    await ref
                        .read(signInViewModelProvider.notifier)
                        .loginWithGoogle();
                if (user != null) {
                  ref
                      .read(signUpViewModelProvider.notifier)
                      .updateFromSocialUser(user);
                  context.push('/sign-up');
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('구글 로그인 실패')));
                }
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
