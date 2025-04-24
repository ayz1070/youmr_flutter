import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:logger/logger.dart';

import '../../../../../core/di/auth_module.dart';
import '../../../../core/constants/social_provider.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  static final Logger _logger = Logger();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInViewModelProvider);
    final viewModel = ref.read(signInViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Color(0xFFB7C9BC),
      body: Stack(
        children: [

          // UI 요소
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              InkWell(
                onTap: () async {
                  final kakaoUser = await kakaoLogin();
                  final account = kakaoUser?.kakaoAccount;

                  if (account != null) {
                    // 1. 카카오 정보 추출
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
                    // 실패!
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('카카오 로그인 실패')),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(10), // 터치 효과 반경
                child: Ink(
                  child: Image.asset(
                    'lib/assets/images/btn_kakao.png',
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


  Future<User?> kakaoLogin() async {
    try {
      if (await isKakaoTalkInstalled()) {
        await UserApi.instance.loginWithKakaoTalk();
        _logger.i('카카오톡으로 로그인 시도');
      } else {
        await UserApi.instance.loginWithKakaoAccount();
        _logger.i('카카오계정(웹)으로 로그인 시도');
      }

      final user = await UserApi.instance.me();
      _logger.i('카카오 로그인 성공');
      _logger.i('카카오ID: ${user.id}');
      _logger.i('닉네임: ${user.kakaoAccount?.profile?.nickname}');
      _logger.i('이메일: ${user.kakaoAccount?.email}');
      _logger.i('프로필사진: ${user.kakaoAccount?.profile?.profileImageUrl}');

      return user;
    } catch (e, stack) {
      _logger.e('카카오 로그인 실패', error:e);
      return null;
    }
  }
}