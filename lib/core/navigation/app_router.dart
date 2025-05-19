import 'package:go_router/go_router.dart';

import '../../features/home/presentation/page/home_page.dart';
import '../../features/sign_up/presentation/pages/sign_in_page.dart';
import '../../features/sign_up/presentation/pages/sign_up_page.dart';
import '../../features/test/test_page.dart';

final GoRouter router = GoRouter(
  routes: [
    // 테스트 라우팅
    GoRoute(path: '/', builder: (context, state) => HomePage()),

    GoRoute(path: '/sign-up', builder: (context, state) => SignUpPage()),

    GoRoute(path: '/sign-in', builder: (context, state) => SignInPage()),

    GoRoute(path: '/home', builder: (context, state) => HomePage()),


    // 관리자 라우팅
  ],
);
