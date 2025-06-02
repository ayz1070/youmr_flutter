import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:youmr_flutter/core/di/auth_module.dart';
import 'package:youmr_flutter/core/theme/app_colors.dart';
import '../provider/member_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(milliseconds: 1600)); // 스플래시 연출용
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      try {
        // 사용자 정보 서버에서 fetch
        final member = await ref
            .read(fetchMemberBySocialIdUseCaseProvider)
            .call(socialId: firebaseUser.uid);

        // 전역 상태에 저장
        ref.read(memberProvider.notifier).setMember(member);

        context.go('/home');
      } catch (e) {
        // 에러 발생 시 로그인 화면으로 이동
        context.go('/sign-in');
      }
    } else {
      context.go('/sign-in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Container(
          height: 150,
          child: Image.asset("lib/assets/icons/app_icon.png"),
        ),
      ),
    );
  }
}
