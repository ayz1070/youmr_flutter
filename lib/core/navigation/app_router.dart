import 'package:go_router/go_router.dart';

import '../../features/home/presentation/page/home_page.dart';
import '../../features/sign_up/presentation/pages/sign_in_page.dart';
import '../../features/sign_up/presentation/pages/sign_up_page.dart';


final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => SignUpPage(),
    ),

    GoRoute(
      path: '/sign-in',
      builder: (context, state) => SignInPage(),
    ),

    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
  ],
);