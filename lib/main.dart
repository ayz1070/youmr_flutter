import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:youmr_flutter/core/util/app_logger.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/test/notification_service.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // 꼭 추가! (비동기 코드에서 안전)
  await dotenv.load(fileName: ".env");

  // .env에서 환경변수 불러오기
  //final kakaoAppKey = dotenv.env['KAKAO_NATIVE_APP_KEY'] ?? '';
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initialize(); // 추가

  KakaoSdk.init(nativeAppKey: "6a5a8f251a4aeec1c6d5db62830f9528");

  final fcmToken = await FirebaseMessaging.instance.getToken();
  AppLogger.i("파이어베이스 메시지 토큰 : ${fcmToken}");


  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'YouMR',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

    );
  }
}