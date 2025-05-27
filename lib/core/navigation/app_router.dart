import 'package:go_router/go_router.dart';
import 'package:youmr_flutter/features/gemini/presentation/page/gemini_page.dart';

import '../../features/home/presentation/page/home_page.dart';
import '../../features/sign_up/presentation/pages/sign_in_page.dart';
import '../../features/sign_up/presentation/pages/sign_up_page.dart';
import '../../features/splash/presentation/page/splash_page.dart';
import '../../features/test/test_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',

  routes: [
    // 테스트 라우팅
    GoRoute(path: '/', builder: (context, state) => SplashPage()),

    GoRoute(path: '/splash', builder: (context, state) => SplashPage()),

    GoRoute(path: '/sign-up', builder: (context, state) => SignUpPage()),

    GoRoute(path: '/sign-in', builder: (context, state) => SignInPage()),

    GoRoute(path: '/home', builder: (context, state) => HomePage()),

    GoRoute(path: '/gemini', builder: (context, state) => GeminiPage()),


    // 관리자 라우팅
  ],
);
