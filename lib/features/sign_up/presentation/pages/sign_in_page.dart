import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/auth_module.dart';


class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFB7C9BC),
      body: Stack(
        children: [
          Column(
            children: [
              const Spacer(),

              // 카카오 로그인
              InkWell(
                onTap: () async {
                  final user = await ref.read(signInViewModelProvider.notifier).loginWithKakao();
                  if (user != null) {
                    ref.read(signUpViewModelProvider.notifier).updateFromSocialUser(user);
                    context.push('/sign-up');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('카카오 로그인 실패')),
                    );
                  }
                },
                child: Image.asset('lib/assets/images/btn_kakao.png'),
              ),

              const SizedBox(height: 16),

              // 구글 로그인
              InkWell(
                onTap: () async {
                  final user = await ref.read(signInViewModelProvider.notifier).loginWithGoogle();
                  if (user != null) {
                    ref.read(signUpViewModelProvider.notifier).updateFromSocialUser(user);
                    context.push('/sign-up');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('구글 로그인 실패')),
                    );
                  }
                },
                child: Image.asset('lib/assets/images/btn_google.png'),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}